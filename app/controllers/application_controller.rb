class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.role == 'admin'
      admin_dashboard_index_path
    elsif resource.is_a?(User) && resource.role == 'manager'
      manager_dashboard_index_path
    else
      customer_dashboard_index_path
    end
  end 

  def after_update_path_for(resource)
    profile_path
  end
end
