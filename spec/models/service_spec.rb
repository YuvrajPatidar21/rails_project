require 'rails_helper'

RSpec.describe Service, type: :model do
  # describe "Associations" do
  #   it { should belongs_to(:hotel) }
  #   it { should have_one_attached(:service_picture)}
  # end

  describe "Validations" do
    let(:service) { build(:service) }

    it "is valid with atrributes" do
      expect(service).to be_valid
    end

    it "is invalid without service name" do
      service.name = nil
      expect(service).to_not be_valid
    end

    it "is invalid without description" do
      service.description = nil
      expect(service).to_not be_valid
    end

    it "is invalid without incorrect length" do
      service.description = "ehfenfke ef jffj eejjfjlf huwij"
      expect(service).to_not be_valid
    end
  end

  describe "Callbacks" do
    describe "before_save" do
      it "transform the name of service to titlelize" do
        service = create(:service, name: "abdef abcdef")
        expect(service.name).to eq("Abdef Abcdef")
      end

      it "transform the description of service to capitalize" do
        service = create(:service, description: "abcdefghijklmnopqrstuvwxyz abcdabcd abcdabcd abcdabcd abcdabcd abcdabcd" )
        expect(service.description).to eq("Abcdefghijklmnopqrstuvwxyz abcdabcd abcdabcd abcdabcd abcdabcd abcdabcd")
      end
      
    end
  end
end
