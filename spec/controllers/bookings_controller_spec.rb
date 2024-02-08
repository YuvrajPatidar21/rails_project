require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { FactoryBot.create(:user, role: "customer") }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:room) { FactoryBot.create(:room, hotel: hotel) }
  let(:booking) { FactoryBot.create(:booking, room: room, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, params: { room_id: room.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @bookings" do
      get :index, params: { room_id: room.id }
      expect(assigns(:bookings)).to eq([booking])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { room_id: room.id, id: booking.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @booking" do
      get :show, params: { room_id: room.id, id: booking.id }
      expect(assigns(:booking)).to eq(booking)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { room_id: room.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns a new booking as @booking" do
      get :new, params: { room_id: room.id }
      expect(assigns(:booking)).to be_a_new(Booking)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Booking" do
        expect {
          post :create, params: { room_id: room.id, booking: FactoryBot.attributes_for(:booking) }
        }.to change(Booking, :count).by(1)
      end

      it "redirects to the booking" do
        post :create, params: { room_id: room.id, booking: FactoryBot.attributes_for(:booking) }
        expect(response).to redirect_to(hotel_room_booking_path(room.hotel, room, Booking.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { room_id: room.id, booking: FactoryBot.attributes_for(:booking, start_date: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested booking and redirects to the bookings list" do
      delete :destroy, params: { room_id: room.id, id: booking.id }
      expect(response).to redirect_to(display_booking_path)
      expect(flash[:notice]).to eq("Booking was successfully Cancled.")
      expect { booking.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end