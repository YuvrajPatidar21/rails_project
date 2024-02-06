require 'rails_helper'

RSpec.describe RoomTypesController, type: :controller do
  let(:user) { FactoryBot.create(:user, role: 'admin') }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:room_type) { FactoryBot.create(:room_type, hotel: hotel) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, params: { hotel_id: hotel.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @room_types" do
      get :index, params: { hotel_id: hotel.id }
      expect(assigns(:room_types)).to eq([room_type])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { hotel_id: hotel.id, id: room_type.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @room_type" do
      get :show, params: { hotel_id: hotel.id, id: room_type.id }
      expect(assigns(:room_type)).to eq(room_type)
    end
  end

  describe "GET #new" do
    it 'return http success' do
      get :new, params: { hotel_id: hotel.id }
      expect(response).to have_http_status(:success)
    end
    it "assigns a new service @service" do
      get :new, params: { hotel_id: hotel.id }
      expect(assigns(:room_type)).to be_a_new(RoomType)
    end
  end

  describe "GET #edit" do
    it 'return http success' do
      get :edit, params: { hotel_id: hotel.id, id: room_type.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested service as @room_type' do
      get :edit, params: { hotel_id: hotel.id, id: room_type.id }
      expect(assigns(:room_type)).to eq(room_type)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new room_type" do
        expect do 
          post :create, params: { hotel_id: hotel.id, room_type: FactoryBot.attributes_for(:room_type) }
        end.to change(RoomType, :count).by(1)
      end

      it "redirect to the room_type" do
        post :create, params: { hotel_id: hotel.id, room_type: FactoryBot.attributes_for(:room_type) }
        expect(response).to redirect_to(hotel_room_types_path(hotel))
      end

      it "set a flash message" do
        post :create, params: { hotel_id: hotel.id, room_type: FactoryBot.attributes_for(:room_type) }
        expect(flash[:notice]).to eq("Room type was successfully created.")
      end
    end

    context "with invalid prams" do
      it "does not create a new room_type" do
        expect do 
          post :create, params: { hotel_id: hotel.id, room_type: FactoryBot.attributes_for(:room_type, name: nil) }
        end.to_not change(RoomType, :count)
      end

      it "render the new template" do
        post :create, params: { hotel_id: hotel.id, room_type: FactoryBot.attributes_for(:room_type, name: nil) }
        expect(response).to render_template(:new)
      end

      it "return the unprocessable entity" do
        post :create, params: { hotel_id: hotel.id, room_type: FactoryBot.attributes_for(:room_type, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_name) { "New Name" }

      # it "updates the requested room type" do
      #   byebug
      #   put :update, params: { hotel_id: hotel.id, id: room_type.id, room_type: { name: new_name } }
      #   room_type.reload
      #   expect(room_type.name).to eq(new_name)
      # end

      it "redirect to the room_type" do
        put :update, params: { hotel_id: hotel.id, id: room_type.id, room_type: FactoryBot.attributes_for(:room_type) }
        expect(response).to redirect_to(hotel_room_types_path(hotel))
      end

      it "sets a notice flash message" do
        put :update, params: { hotel_id: hotel.id,id: room_type.id, room_type: FactoryBot.attributes_for(:room_type) }
        expect(flash[:notice]).to eq("Room type was successfully updated.")
      end
    end

    context "with invalid params" do
      it "return a successful response with unprocessable entity " do
        put :update, params: { hotel_id: hotel.id,id: room_type.id, room_type: FactoryBot.attributes_for(:room_type, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "render the edit template" do
        post :update, params: { hotel_id: hotel.id, id: room_type.id, room_type: FactoryBot.attributes_for(:room_type, name: nil) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested service and redirects with notice message" do
      delete :destroy, params: { hotel_id: hotel.id, id: room_type.id }
      expect(response).to redirect_to(hotel_room_types_path(hotel))
      expect(flash[:notice]).to eq("Room type was successfully destroyed.")
      expect { room_type.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end