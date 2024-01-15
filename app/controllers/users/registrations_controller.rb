class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :mobile, :address, :city, :date_of_birth, :status, :role, :state, :zipcode, :password, :password_confirmation, :profile_picture])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :mobile, :address, :city, :date_of_birth, :status, :role, :state, :zipcode, :password, :password_confirmation,:profile_picture])
  end

  def after_update_path_for(resource)
    profile_path(resource)
  end
end
