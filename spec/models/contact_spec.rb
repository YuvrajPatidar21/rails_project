require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "Validations" do
    let(:contact) { build(:contact) }
    it "is valid eith atributes" do
      expect(contact).to be_valid 
    end

    it "is invalid without name" do
      contact.name = nil
      expect(contact).to_not be_valid
    end

    it "is invalid without email" do
      contact.email = nil
      expect(contact).to_not be_valid
    end

    it "is invalid without correct format" do
      contact.email = "testgmailcom"
      expect(contact).to_not be_valid
    end
    
    it "is invalid without subject" do
      contact.subject = nil
      expect(contact).to_not be_valid
    end

    it "is invalid without incorrect length" do
      contact.subject = "ascderfdsa"
      expect(contact).to_not be_valid
    end

    it "is invalid without message" do
      contact.message = nil
      expect(contact).to_not be_valid
    end

    it "is invalid without incorrect length" do
      contact.message = "ascderfdsa ascderfdsa ascderfdsa ascder"
      expect(contact).to_not be_valid
    end
  end

  describe"callbacks" do
    let(:contact) {build(:contact) }
    describe "before_save" do
      it "transform the name into titlieze" do
        contact = create(:contact, name: "my name")
        expect(contact.name).to eq("My Name")
      end

      it "transform the subject into titlieze" do
        contact = create(:contact, subject:"subject subject subject subject subject")
        expect(contact.subject).to eq("Subject Subject Subject Subject Subject")
      end

      it "transform the message into capitalized" do
        contact = create(:contact, message: "abcd efghi jkl mno pqr stu wxyz abcd efghi jkl mno pqr stu wxyz")
        expect(contact.message).to eq("Abcd efghi jkl mno pqr stu wxyz abcd efghi jkl mno pqr stu wxyz")
      end
    end
  end

end
