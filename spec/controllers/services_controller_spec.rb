require 'rails_helper'

RSpec.describe ServicesController, type: :controller do
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:service) { FactoryBot.create(:service, hotel: hotel) }

  before do
    sign_in FactoryBot.create(:user, role: 'admin')
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, params: { hotel_id: hotel.id }
      expect(response).to have_http_status(:success)  
    end

    it "assigns @services" do
      get :index, params: { hotel_id: hotel.id }
      expect(assigns(:services)).to eq([service])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { hotel_id: hotel.id, id: service.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @service" do
      get :show, params: { hotel_id: hotel.id, id: service.id }
      expect(assigns(:service)).to eq(service)
    end
  end

  describe "GET #new" do
    it 'return http success' do
      get :new, params: { hotel_id: hotel.id }
      expect(response).to have_http_status(:success)
    end
    it "assigns a new service @service" do
      get :new, params: { hotel_id: hotel.id }
      expect(assigns(:service)).to be_a_new(Service)
    end
  end

  describe "GET #edit" do
    it 'return http success' do
      get :edit, params: { hotel_id: hotel.id, id: service.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested service as @service' do
      get :edit, params: { hotel_id: hotel.id, id: service.id }
      expect(assigns(:service)).to eq(service)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new service" do
        expect do
          post :create, params: { hotel_id: hotel.id, service: FactoryBot.attributes_for(:service) }
        end.to change(Service, :count).by(1)
      end
    
      it "redirect to the service" do
        post :create, params: { hotel_id: hotel.id, service: FactoryBot.attributes_for(:service) }
        expect(response).to redirect_to(hotel_services_path(hotel))
      end

      it "sets a notice flash message" do
        post :create, params: { hotel_id: hotel.id, service: FactoryBot.attributes_for(:service) }
        expect(flash[:notice]).to eq("Service was successfully created.")
      end
    end
    context "with invalid params" do
      it "doesnot create a new service" do
        expect do
          post :create, params: { hotel_id: hotel.id, service: FactoryBot.attributes_for(:service, name: nil) }
        end.not_to change(Service, :count)
      end

      it "render the new template" do
        post :create, params: { hotel_id: hotel.id, service: FactoryBot.attributes_for(:service, name: nil) }
        expect(response).to render_template(:new)
      end

      it "return the unprocessable entity" do
        post :create, params: { hotel_id: hotel.id, service: FactoryBot.attributes_for(:service, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_name) {'New Service Name'}
      it "updates the requested service" do
        put :update, params: {hotel_id: hotel.id, id: service.id, service: { name: new_name } }
        service.reload
        expect(service.name).to eq(new_name)
      end

      it "redirect to the service" do
        put :update, params: { hotel_id: hotel.id, id: service.id, service: FactoryBot.attributes_for(:service) }
        expect(response).to redirect_to(hotel_services_path(hotel))
      end

      it "sets a notice flash message" do
        put :update, params: { hotel_id: hotel.id,id: service.id, service: FactoryBot.attributes_for(:service) }
        expect(flash[:notice]).to eq("Service was successfully updated.")
      end
    end

    context "with invalid params" do
      it "return a successful response with unprocessable entity " do
        put :update, params: { hotel_id: hotel.id,id: service.id, service: FactoryBot.attributes_for(:service, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "render the edit template" do
        post :update, params: { hotel_id: hotel.id, id: service.id, service: FactoryBot.attributes_for(:service, name: nil) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested service and redirects with notice message" do
      delete :destroy, params: { hotel_id: hotel.id, id: service.id }
      expect(response).to redirect_to(hotel_services_path(hotel))
      expect(flash[:notice]).to eq("Service was successfully destroyed.")
      expect { service.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end