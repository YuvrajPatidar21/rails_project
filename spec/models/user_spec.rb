require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_and_belong_to_many(:hotels) }
    it { should have_one_attached(:profile_picture) }
    it { should have_many(:bookings).dependent(:destroy) }
    it { should have_many(:rooms).through(:bookings).dependent(:destroy) }
    it { should have_many(:payments).through(:bookings).dependent(:destroy) }
  end

  describe "Validations" do
    let(:user) {build(:user) }
    it "is valid with atrributes" do
      expect(user).to be_valid
    end

    it "is invalid without name" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "is invalid without email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a unique email" do
      existing_user = create(:user)
      user.email = existing_user.email
      expect(user).to_not be_valid
    end

    it "is invalid without a valid format" do
      user.email = "abcdef_ghijkl"
      expect(user).to_not be_valid
    end

    it "is invalid without a mobile number" do
      user.mobile = nil
      expect(user).to_not be_valid
    end

    it "is invalid with duplicate mobile number" do
      existing_user = create(:user, mobile: user.mobile)
      expect(user).to_not be_valid
    end

    it "is invalid without a valid mobile number format" do
      user.mobile = "123-456-7890"
      expect(user).to_not be_valid
    end

    it "is invalid without an address" do
      user.address = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a date of birth" do
      user.date_of_birth = nil
      expect(user).to_not be_valid
    end

    it "is invalid if date of birth is in future" do
      user.date_of_birth = Date.current + 1.day
      expect(user).to_not be_valid
    end

    it "is invalid without a status" do
      user.status = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a city" do
      user.city = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a state" do
      user.state = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a zipcode" do
      user.zipcode = nil
      expect(user).to_not be_valid
    end

    it "is invalid if zipcode is non numberical" do
      user.zipcode = "ABCDEF"
      expect(user).to_not be_valid
    end

    it "is invalid if zipcode of incorrect length" do
      user.zipcode = "12345678"
      expect(user).to_not be_valid
    end

  end

  describe "Callbacks" do
    describe "after_create" do
      it "sends a welcome mail after create " do
        user = build(:user)
        expect { user.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
  
  describe "enums" do
    it "defines the correct enum values for role" do
      should define_enum_for(:role).with_values([:customer, :manager, :admin])
    end
  end
  
  describe "Private methods" do
    describe "#set default role" do
      it "sets the default role to customer for new record" do
        user = create(:user)
        expect(user.role).to eq("customer")
      end

      it "does not change the role if role already set" do
        user = create(:user, role: "manager")
        expect(user.manager?).to be(true)
      end
    end

    describe "#validate_date_of_birth" do
      let(:user) { create(:user) }
      it "add an erroris the date of birth is in future" do
        if user.date_of_birth > Date.today
          expect(user.date_of_birth).to_not be_valid
          expect(user.errors[:date_of_birth]).to include ("must be in past")
        end
      end
    end
  end
end
