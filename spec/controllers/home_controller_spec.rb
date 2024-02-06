require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    let(:hotel) { create(:hotel) }
    it "assigns @hotels" do
      get :index
      expect(assigns(:hotels)).to eq([hotel])  
    end

    it "render the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #about" do
    it "render the about template" do
      get :about
      expect(response).to render_template("about")
    end
  end

  describe "GET #home_service" do
    it "render the home service template" do
      get :home_service
      expect(response).to render_template("home_service")
    end
  end

  describe "GET #profile" do
    it "render the profile template" do
      get :profile
      expect(response).to render_template("profile")
    end
  end

  describe "GET #contact" do
    it "assign a new contact" do
      get :contact
      expect(assigns(:contact)).to be_a_new(Contact)
    end
|
    it "redner the contact template" do
      get :contact
      expect(response).to render_template("contact")
    end
  end

  describe "POST #process_contact" do
    context "with valid parameters" do
      let(:valid_params) { { contact: { name: "John", email: "john@gmail.com", subject: "This is subject for contact us form.", message: "This is the area where the visiter can give the feedback using fill this form."  } } }
    
      it "creates a new contact" do
        expect {
          post :process_contact, params: valid_params
        }.to change(Contact, :count).by(1)
      end
    
      it "sends an email" do
        expect {
          post :process_contact, params: valid_params 
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    
      it "redirects to root_path" do
        post :process_contact, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    
      it "sets a notice flash message" do
        post :process_contact, params: valid_params
        expect(flash[:notice]).to eq('Thank you for contacting us!')
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { contact: { name: nil, email: "invalid_email", subject: "subject", message: "message" } } }

      it "does not create a new contact" do
        expect {
          post :process_contact, params: invalid_params
        }.not_to change(Contact, :count)
      end

      it "render the contact template" do
        post :process_contact, params: invalid_params
        expect(response).to render_template("contact")
      end
    end
    

  end
end
