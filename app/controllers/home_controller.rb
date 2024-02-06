class HomeController < ApplicationController
  layout "home"
  def index
    @hotels = Hotel.all
    @contact = Contact.new
  end
 
  def about
  end
  
  def home_service
  end
  
  def profile
  end

  def contact
    @contact = Contact.new
  end

  def process_contact
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        ContactMailer.contact_email(@contact).deliver_now
        format.html { redirect_to root_path, notice: 'Thank you for contacting us!' }
      else
        format.html { render :contact, status: :unprocessable_entity }
      end
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :subject ,:message)
    end
end
