require 'rails_helper'

RSpec.describe Payment, type: :model do
  # describe "Associations" do
  #   it { should belongs_to(:booking) }
  # end

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

  describe "Callbacks" do
    let(:payment) { create(:payment) } # Assuming you have FactoryBot factories set up
    let(:booking) { payment.booking }

    it "updates booking status to 'Booked' after create" do
      expect(booking.status).to eq("Booked")
    end

    # it "sends booking status 'Booked' after create" do
    #   expect(BookingMailer).to receive(:booking_status_booked).with(booking).and_return(double(deliver_now: true))
    #   payment.save
    # end

    it "assigns hotel to user after create" do
      expect(booking.room.hotel.users).to include(booking.user)
    end

    # it "does not assign duplicate hotel to user after create" do
    #   booking.room.hotel.users << booking.user
    #   expect(booking.room.hotel.users.count).to eq(1)
    # end
  end
end
