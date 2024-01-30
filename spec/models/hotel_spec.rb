  require 'rails_helper'

  RSpec.describe Hotel, type: :model do
    
    describe "Associations" do
      it { should have_and_belong_to_many(:users).dependent(:destroy) }
      it { should have_many(:services).dependent(:destroy) }
      it { should have_many(:room_types). dependent(:destroy) }
      it { should have_many(:rooms).dependent(:destroy) }
      it { should have_many(:bookings).through(:rooms).dependent(:destroy) }
      it { should have_many(:payments).through(:bookings).dependent(:destroy) }
      it { should have_many_attached(:hotel_pictures) }
    end

    describe "Validations" do
      let(:hotel) {build(:hotel) }

      it "is valid with attributes" do
        expect(hotel).to be_valid
      end
      
      it "is invalid without hotel name" do
        hotel.name = nil
        expect(hotel).to_not be_valid
      end

      it "is invalid if hotel name is not unique" do
        existing_hotel = create(:hotel)
        hotel.name = existing_hotel.name
        expect(hotel).to_not be_valid
      end

      it "is invalid without hotel email" do
        hotel.email = nil
        expect(hotel).to_not be_valid
      end
      
      it "is invalid if hotel name is not unique" do
        existing_hotel = create(:hotel)
        hotel.email = existing_hotel.email
        expect(hotel).to_not be_valid  
      end

      it "is invalid without valid email format" do
        hotel.email =  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        expect(hotel).to_not be_valid
      end

      it "is invalid wihtout telephone number" do
        hotel.telephone = nil
        expect(hotel).to_not be_valid
      end

      it "is invalid without if telephone number is duplicate" do
        existing_hotel = create(:hotel)
        hotel.telephone = existing_hotel.telephone
        expect(hotel).to_not be_valid
      end

      it "is invalid without valid format" do
        hotel.telephone = "123-456-7890"
        expect(hotel).to_not be_valid
      end

      it "is invalid if the telephone is not number" do
        hotel.telephone = "ABCDEFGHIJ"
        expect(hotel).to_not be_valid
      end

      it "is invalid if telephone is incorrect length" do
        hotel.telephone = "123456789012"
        expect(hotel).to_not be_valid
      end

      it "is invalid without location" do
        hotel.location = nil
        expect(hotel).to_not be_valid
      end
      
      it "is invalid if the location is duplicate" do
        existing_hotel = create(:hotel)
        hotel.location= existing_hotel.location
        expect(hotel).to_not be_valid
      end

      it "is invalid without city" do
        hotel.city = nil
        expect(hotel).to_not be_valid
      end
      
      it "is invalid without state" do
        hotel.state = nil
        expect(hotel).to_not be_valid
      end

      it "is invalid without zipcode" do
        hotel.zipcode = nil
        expect(hotel).to_not be_valid
      end

      it "is invalid if the zipcode is not number" do
        hotel.zipcode = "ABCDEF"
        expect(hotel).to_not be_valid
      end

      it "is invalid if zipcode incorrect length" do
        hotel.zipcode = "12345343"
        expect(hotel).to_not be_valid
      end

      it "is invalid without description" do
        hotel.description = nil
        expect(hotel).to_not be_valid
      end
    end

    describe "Callbacks" do
      describe "before_save" do
        it "transform name to uppercase" do
          hotel = create(:hotel, name: "abcdefghijklmnopqrstuvwxyz")
          expect(hotel.name).to eq("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        end

        it "transform location to titlelize" do
          hotel = create(:hotel, location: "12, abcdef abcd abd")
          expect(hotel.location).to eq("12, Abcdef Abcd Abd")
        end

        it "transform city to titleize" do
          hotel = create(:hotel, city: "abcdef sdhksh")
          expect(hotel.city).to eq("Abcdef Sdhksh")
        end

        it "transform state to titleize" do
          hotel = create(:hotel, state: "madhya pradesh")
          expect(hotel.state).to eq("Madhya Pradesh")
        end

        it "transform description to capitalize" do
          hotel = create(:hotel, description: "abcdefghijklmnopq rstuvraj")
          expect(hotel.description).to eq("Abcdefghijklmnopq rstuvraj")
        end
      end
    end

  end
