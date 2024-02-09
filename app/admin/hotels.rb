ActiveAdmin.register Hotel do
  permit_params :name, :email, :telephone, :location, :city, :state, :zipcode, :description

  filter :name
  filter :id, as: :select
end
