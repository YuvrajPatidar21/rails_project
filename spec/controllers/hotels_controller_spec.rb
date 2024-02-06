require 'rails_helper'
RSpec.describe HotelsController, type: :controller do
  let(:user) { FactoryBot.create(:user, role: 'admin') }
  let(:hotel) { FactoryBot.create(:hotel) }

  before do
    sign_in user
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)  
    end

    it "assigns @hotels" do
      get :index
      expect(assigns(:hotels)).to eq([hotel])
    end
  end
  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: hotel.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @hotel" do
      get :show, params: { id: hotel.id }
      expect(assigns(:hotel)).to eq(hotel)
    end

    it "assigns @services" do
      services = FactoryBot.create_list(:service, 3, hotel: hotel)
      get :show, params: { id: hotel.id }
      expect(assigns(:services)).to eq(services)
    end
  end
  
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "aasigns a new hotel @hotel" do
      get :new
      expect(assigns(:hotel)).to be_a_new(Hotel)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: hotel.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested hotel as @hotel" do
      get :edit, params: { id: hotel.id }
      expect(assigns(:hotel)).to eq(hotel)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Hotel" do
        expect {
          post :create, params: { hotel: FactoryBot.attributes_for(:hotel) }
        }.to change(Hotel, :count).by(1)
      end

      it "redirects to the hotel" do
        put :create, params: { hotel: FactoryBot.attributes_for(:hotel) }
        expect(response).to redirect_to(hotel_url(assigns(:hotel)))
      end

      it "sets a notice flash message" do
        post :create, params: { hotel: FactoryBot.attributes_for(:hotel) }
        expect(flash[:notice]).to eq("Hotel was successfully created.")
      end
    end
    context "with invalid params" do
      it "does not create new hotel with invalid params" do
        expect {
                post :create, params: { hotel: FactoryBot.attributes_for(:hotel, name: nil) }
              }.not_to change(Hotel, :count)
      end
      it "render the new template" do
        post :create, params: { hotel: FactoryBot.attributes_for(:hotel, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_name) {"NEW NAME HOTEL"}
      it "updates the requested hotel" do
        put :update, params: { id: hotel.id, hotel: { name: new_name } }
        hotel.reload
        expect(hotel.name).to eq(new_name)
      end


      it "redirects to the hotel" do
        put :update, params: { id: hotel.id, hotel: FactoryBot.attributes_for(:hotel) }
        expect(response).to redirect_to(:hotel)
      end
    end

    context "with invalid params" do
      it "returns a success response with unprocessable entity" do
        put :update, params: { id: hotel.id, hotel: FactoryBot.attributes_for(:hotel, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "render the edit template" do
        post :update, params: { id: hotel.id, hotel: FactoryBot.attributes_for(:hotel, name: nil) }
        expect(response).to render_template(:edit)
      end

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested service and redirects with notice message" do
      delete :destroy, params: { id: hotel.id }
      expect(response).to redirect_to(hotels_url)
      expect(flash[:notice]).to eq("Hotel was successfully destroyed.")
      expect { hotel.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end