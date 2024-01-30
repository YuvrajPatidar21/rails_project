require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "Associations" do
    it { should belong_to(:booking) }
  end

  describe "Validations" do
    let(:payment) { build(:payment) }

    it "is valid with attributes" do
      expect(payment).to be_valid
    end

    it "is invalid wihtout card holder name" do
      payment.card_holder_name = nil
      expect(payment).to_not be_valid
    end

    it "is invalid without card number" do
      payment.card_number = nil
      expect(payment).to_not be_valid
    end

    it "invalid without incorrect format of card number" do
      payment.card_number = "AVBCNDJD"
      expect(payment).to_not be_valid
    end

    it "is invalid without incorrect length of card number" do
      payment.card_number = 12345
      expect(payment).to_not be_valid
    end

    it "is valid with correct length and format of card number" do
      payment.card_number = 1234567891234567
      expect(payment).to be_valid
    end

    it "is invalid without cvv number" do
      payment.cvv = nil
      expect(payment).to_not be_valid
    end

    it "is invalid without without incorrect format of cvv" do
      payment.cvv = "AVD"
      expect(payment).to_not be_valid
    end

    it "is invalid without incorrect length of cvv" do
      payment.cvv = "1234"
      expect(payment).to_not be_valid
    end

    it "is valid with correct length and format of cvv" do
      payment.cvv = 123
      expect(payment).to be_valid
    end

    it "is invalid without bank name" do
      payment.bank_name = nil
      expect(payment).to_not be_valid
    end
  end
  
  describe "callbacks" do
    describe"before create" do
      it "sets the amount before creation" do
        booking = create(:booking) # Assuming FactoryBot is set up for Booking
        payment = build(:payment, booking: booking, amount: nil)
        payment.save
        expect(payment.amount).to eq(booking.calculate_amount)
      end
    end

    describe "after create" do
      it "marks booking status as Booked" do
        payment = create(:payment)
        expect(payment.booking.status).to eq("Booked")
      end

      before do
        allow(BookingMailer).to receive(:booking_status_booked).and_return(double("BookingMailer", deliver_now: true))
      end

      it "send_booking_status_booked after payment" do
        payment = create(:payment)
        expect(BookingMailer).to have_received(:booking_status_booked).with(payment)
      end

      it "assign hotel to user" do
        user = create(:user)
        hotel = create(:hotel)
        room = create(:room, hotel: hotel) 
        booking = create(:booking, room:room, user: user )
        payment = create(:payment, booking: booking)
        
        expect(hotel.users).to include(user)
      end

    end
  end
end
