class HomeController < ApplicationController
  layout "home"
  def index
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
    if @contact.save
      ContactMailer.contact_email(@contact).deliver_now
      redirect_to root_path, notice: 'Thank you for contacting us!'
    else
      render :contact
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :subject ,:message)
    end
end
