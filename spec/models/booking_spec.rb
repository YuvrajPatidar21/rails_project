require 'rails_helper'
RSpec.describe Booking, type: :model do
  
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
    it { should have_one(:payment).dependent(:destroy) }
  end
  
  let(:room) { create(:room) }
  let(:user) { create(:user) }
  describe "Validations" do
    let(:booking) { build(:booking)}
    it "is valid with attributes" do
      expect(booking).to be_valid
    end

    it "is invalid without start_date" do
      booking.start_date = nil
      expect(booking).to_not be_valid
    end

    it "is invalid without end_date" do
      booking.end_date = nil
      expect(booking).to_not be_valid
    end

    it "validates end_date after start_date" do
      booking.start_date = Date.today
      booking.end_date = Date.yesterday
      expect(booking).to_not be_valid
      expect(booking.errors[:end_date]).to include("must be a after start date")
    end

    it "validates start_date not in the past" do
      booking.start_date = Date.today - 2.days
      expect(booking).to_not be_valid
      expect(booking.errors[:start_date]).to include("must be in present or future")
    end

    it "validates room availability" do
      create(:booking, start_date: Date.today, end_date: Date.today + 5, room: room, user: user)
      booking = build(:booking, start_date: Date.today + 3, end_date: Date.today + 7, room: room, user: user)
      expect(booking).to_not be_valid
      expect(booking.errors[:base]).to include("Room is not available for the selected dates")
    end
  end

  describe "Callbacks" do
    before do
      allow(BookingMailer).to receive(:booking_status_pending).and_return(double("BookingMailer", deliver_now: true))
      allow(BookingMailer).to receive(:booking_cancle).and_return(double("BookingMailer", deliver_now: true))
    end
    
    it "marks booking as pending before creation" do
      booking = create(:booking, room: room, user: user)
      expect(booking.status).to eq("Pending")
    end    

    it "sends booking status after save" do
      booking = create(:booking, room: room, user: user)
      expect(BookingMailer).to have_received(:booking_status_pending).with(booking)
    end

    it "sends cancellation after destroy" do
      booking = create(:booking, room: room, user: user)
      booking.destroy
      expect(BookingMailer).to have_received(:booking_cancle).with(booking)
    end
  end

  describe "#calculate_ammount" do
    it "calculate the total amount of booking" do
      room_type_price = 100
      start_date = Date.today
      end_date = Date.today + 2.days
      booking = create(:booking, start_date: start_date, end_date: end_date, room: create(:room, room_type: create(:room_type, price: room_type_price)), user: user)
      expected_amount = (end_date - start_date + 1).to_i * room_type_price
      expect(booking.calculate_amount).to eq(expected_amount)
    end
  end
end
