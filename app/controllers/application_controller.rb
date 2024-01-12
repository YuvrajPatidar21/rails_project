class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    # Check the role of the signed-in user and redirect accordingly
    if resource.is_a?(User) && resource.role == 'admin'
      admin_dashboard_index_path # Example redirect for an admin user
    elsif resource.is_a?(User) && resource.role == 'manager'
      manager_dashboard_index_path # Example redirect for a manager user
    else
      customer_dashboard_index_path # Default redirect for other users
    end
  end 

  def after_update_path_for(resource)
    profile_path
  end
end
