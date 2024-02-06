require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:booking) { FactoryBot.create(:booking, user: user) }
  let(:payment) { FactoryBot.create(:payment, booking: booking) }

  before do
    sign_in user
  end

  describe "GET #display_payment" do
    it "returns http success" do
      get :display_payment
      expect(response).to have_http_status(:success)
    end

    it "assigns @payments" do
      get :display_payment
      expect(assigns(:payments)).to eq([payment])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { booking_id: booking.id, id: payment.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @payment" do
      get :show, params: { booking_id: booking.id, id: payment.id }
      expect(assigns(:payment)).to eq(payment)
    end
  end

  describe "GET #invoice" do
    it "returns http success" do
      get :invoice, params: { booking_id: booking.id, id: payment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { booking_id: booking.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns a new payment as @payment" do
      get :new, params: { booking_id: booking.id }
      expect(assigns(:payment)).to be_a_new(Payment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Payment" do
        expect {
          post :create, params: { booking_id: booking.id, payment: FactoryBot.attributes_for(:payment) }
        }.to change(Payment, :count).by(1)
      end

      it "redirects to the payment" do
        post :create, params: { booking_id: booking.id, payment: FactoryBot.attributes_for(:payment) }
        expect(response).to redirect_to(booking_payment_path(booking, Payment.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { booking_id: booking.id, payment: FactoryBot.attributes_for(:payment, card_holder_name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
