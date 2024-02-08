require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'Associations ' do
    it { should belong_to(:hotel) }
    it { should belong_to(:room_type) }
    it { should have_many(:users).through(:bookings) }
    it { should have_many(:bookings).dependent(:destroy) }
    it { should have_many_attached(:room_pictures)  }
  end

  let(:room) { build(:room) }
  describe "Validations" do

    it " is valid with attributes" do
      expect(room).to be_valid
    end

    it "is invalid wihtout room number" do
      room.room_number = nil
      expect(room).to_not be_valid
    end
    it "is invalid wihtout status" do
      room.status = nil
      expect(room).to_not be_valid
    end

    it "is invalid without a hotel association" do 
      room.hotel = nil
      expect(room).to_not be_valid
    end

    it "is invalid without a room_type association" do
      room.room_type = nil
      expect(room).to_not be_valid
    end

  end

  describe "enums" do
    it "defines the correct enum values for status" do
      should define_enum_for(:status).with_values([:Available, :Booked])
    end
  end

  describe "Callbacks" do
    describe "before_create" do
      it "set default status to Available before create" do
        expect(room.status).to eq("Available")
      end
    end
  end

  describe "#availability?" do
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 5 }
    let(:room) { create(:room) }

    it "returns true if room is available for given dates" do
      build(:booking, room: room, start_date: start_date, end_date: end_date )
      expect(room.availability?(start_date, end_date, room.id)).to be(true)
    end

    it "returns false if room is not available for given dates" do
      create(:booking, room: room, start_date: start_date, end_date: end_date)
      expect(room.availability?(start_date, end_date, room.id)).to be(false)
    end
  end
end
