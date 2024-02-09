ActiveAdmin.register User do
  
  permit_params :name, :email, :mobile, :address, :city, :date_of_birth, :status, :role, :state, :zipcode, :password, :password_confirmation, :profile_picture, hotel_ids: []
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :mobile
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :address
    column :role
    column :hotels
    actions
  end
  
  filter :email
  filter :name
  filter :roles
  filter :created_at
  
  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :name
      f.input :mobile
      f.input :date_of_birth, as: :date_select, start_year: Date.current.year - 100, end_year: Date.current.year
      f.input :status, as: :select, collection: ["Single", "Married"]
      f.input :address
      f.input :city
      f.input :state, as: :select, collection: [ "Andhra Pradesh",
                                                  "Arunachal Pradesh",
                                                  "Assam",
                                                  "Bihar",
                                                  "Chhattisgarh",
                                                  "Goa",
                                                  "Gujarat",
                                                  "Haryana",
                                                  "Himachal Pradesh",
                                                  "Jammu and Kashmir",
                                                  "Jharkhand",
                                                  "Karnataka",
                                                  "Kerala",
                                                  "Madhya Pradesh",
                                                  "Maharashtra",
                                                  "Manipur",
                                                  "Meghalaya",
                                                  "Mizoram",
                                                  "Nagaland",
                                                  "Odisha",
                                                  "Punjab",
                                                  "Rajasthan",
                                                  "Sikkim",
                                                  "Tamil Nadu",
                                                  "Telangana",
                                                  "Tripura",
                                                  "Uttarakhand",
                                                  "Uttar Pradesh",
                                                  "West Bengal",
                                                  "Andaman and Nicobar Islands",
                                                  "Chandigarh",
                                                  "Dadra and Nagar Haveli",
                                                  "Daman and Diu",
                                                  "Delhi",
                                                  "Lakshadweep",
                                                  "Puducherry"]
      f.input :zipcode
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: User.roles.keys.map { |role| [role, role] }
      f.input :profile_picture, as: :file
      # f.input :hotels, as: :check_boxes, collection: Hotel.all
    end
    f.inputs "Assigned Hotels" do
      f.input :hotels, as: :check_boxes, collection: Hotel.all
    end
    f.actions
  end
end
