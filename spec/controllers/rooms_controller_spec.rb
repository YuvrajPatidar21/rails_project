require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { FactoryBot.create(:user, role: 'admin') }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:room_type) { FactoryBot.create(:room_type) }
  let(:room) { FactoryBot.create(:room, hotel: hotel) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, params: { hotel_id: hotel.id, room_type_id: room_type.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @rooms" do
      get :index, params: { hotel_id: hotel.id, room_type_id: room_type.id }
      expect(assigns(:rooms)).to eq([room])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @room" do
      get :show, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id }
      expect(assigns(:room)).to eq(room)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { hotel_id: hotel.id, room_type_id: room_type.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns a new room as @room" do
      get :new, params: { hotel_id: hotel.id, room_type_id: room_type.id }
      expect(assigns(:room)).to be_a_new(Room)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested room as @room" do
      get :edit, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id }
      expect(assigns(:room)).to eq(room)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Room" do
        expect do
          room
          post :create, params: { hotel_id: hotel.id, room_type_id: room_type.id, room: FactoryBot.attributes_for(:room) }
        end.to change(Room, :count).by(1)
      end

      # it "redirects to the rooms list" do
      #   post :create, params: { hotel_id: hotel.id, room_type_id: room_type.id, room: FactoryBot.attributes_for(:room) }
      #   expect(response).to redirect_to(hotel_rooms_path(hotel))
      # end
    end

    context "with invalid params" do
      it "doesnot create a new service" do
        expect do
          post :create, params: { hotel_id: hotel.id, room: FactoryBot.attributes_for(:room, room_number: nil) }
        end.not_to change(Room, :count)
      end

      it "render the new template" do
        post :create, params: { hotel_id: hotel.id, room: FactoryBot.attributes_for(:room, room_number: nil) }
        expect(response).to render_template(:new)
      end

      it "returns the unprocessable entity" do
        post :create, params: { hotel_id: hotel.id, room_type_id: room_type.id, room: FactoryBot.attributes_for(:room, room_number: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_room_number) { "101" }

      it "updates the requested room" do
        put :update, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id, room: { room_number: new_room_number } }
        room.reload
        expect(room.room_number).to eq(new_room_number)
      end

      it "redirects to the rooms list" do
        put :update, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id, room: FactoryBot.attributes_for(:room) }
        expect(response).to redirect_to(hotel_rooms_path(hotel))
      end

      it "sets a notice flash message" do
        post :update, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id, room: FactoryBot.attributes_for(:room) }
        expect(flash[:notice]).to eq("Room was successfully updated.")
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id, room: FactoryBot.attributes_for(:room, room_number: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "render the edit template" do
        post :update, params: { hotel_id: hotel.id, room_type_id: room_type.id, id: room.id, room: FactoryBot.attributes_for(:room, room_number: nil) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested room and redirects with notice message" do
      delete :destroy, params: { hotel_id: hotel.id, id: room.id }
      expect(response).to redirect_to(hotel_rooms_path(hotel))
      expect(flash[:notice]).to eq("Room was successfully destroyed.")
      expect { room.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
