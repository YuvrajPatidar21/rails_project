require 'rails_helper'

RSpec.describe RoomType, type: :model do
  describe "Associations" do
    it { should belong_to(:hotel) }
    it { should have_many(:rooms).dependent(:destroy) }
    it { should have_one_attached(:rooms_type_picture) }
  end

  describe "Validations" do
    let(:room_type) { build(:room_type) }

    it "is valid with attributes" do
      expect(room_type).to be_valid
    end

    it "is invlid with wihtout name" do
      room_type.name = nil
      expect(room_type).to_not be_valid
    end

    it "is invlid with wihtout price" do
      room_type.price = nil
      expect(room_type).to_not be_valid
    end
    it "is valid with correct format" do
      room_type.price = 500
      expect(room_type).to be_valid
    end
    it "is invalid without incorect format of price" do
      room_type.price = "ABCD"
      expect(room_type).to_not be_valid
    end

    it "is invalid without description"do
      room_type.description = nil
      expect(room_type).to_not be_valid
    end

    it "is invalid without incorect length" do
      room_type.description = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      expect(room_type).to_not be_valid
    end

    it "is invalid without capacity" do
      room_type.capacity = nil
      expect(room_type).to_not be_valid
    end

    it "is invalid without incorect format of capacity" do
      room_type.capacity = "A"
      expect(room_type).to_not be_valid
    end

    it "is invalid without a hotel association" do
      room_type.hotel = nil
      expect(room_type).to_not be_valid
    end
  end

  describe "CallBack" do
    describe "before_save" do
      it "transform the name of the room_type to titleize" do
        room_type = create( :room_type, name: "standard room" )
        expect(room_type.name).to eq("Standard Room")
      end

      it "transform the description of the room_type to capatalize" do
        room_type = create(:room_type, description: "abcdef ghijklmn abcdef ghijklmn abcdef ghijklmn abcdef ghijklmn abcdef ghijklmn")
        expect(room_type.description).to eq( "Abcdef ghijklmn abcdef ghijklmn abcdef ghijklmn abcdef ghijklmn abcdef ghijklmn" )
      end

    end
  end
end
