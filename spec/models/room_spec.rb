require 'rails_helper'

RSpec.describe Room, type: :model do
  # describe 'Associations ' do
  #   it { should belongs_to(:hotel) }
  #   it { should belongs_to(:room_type) }
  #   it { should have_many(:users).through(:bookings) }
  #   it { should have_many(:bookings).dependent(:destroy) }
  #   it { should have_many_attached(:room_pictures)  }
  # end

  let(:room) { build(:room) }
  describe "Validations" do

    it " is valid with attributes" do
      expect(room).to be_valid
    end

    it "is invalid wihtout room number" do
      room.room_number = nil
      expect(room).to_not be_valid
    end
    it "is invalid wihtout statys" do
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

  # describe "Enums" do
  #   it { should define_enum_for(:status).with_values([:Available, :Booked]) }
  # end

  describe "Callbacks" do
    describe "before_create" do
      it "set default status to Available before create" do
        expect(room.status).to eq("Available")
      end
    end
  end

  # describe "Method" do
  #   describe "#avaibility?" do
  #     it "return true if the room is avilable for the given dates" do
  #       start_date = Date.today
  #       end_date = Date.today+ 3.days
  #       expect(room.avaibility?(start_date, end_date, room)).to be(true)
  #     end

  #     it "return false when room is not available for the given dates" do
  #       conflicting_bookings = create(:bookings, room: room)
  #       start_date = conflicting_bookings.start_date
  #       end_date = conflicting_bookings.end_date
  #       expect(room.avaibility?(start_date, end_date, room)).to be(false)
  #     end
  #   end
  # end
end
