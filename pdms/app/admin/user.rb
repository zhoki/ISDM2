ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  
  index do
   column :id
   column :firstName
   column :lastName
   column :email
   column :role
   column :sign_in_count
   column :last_sign_in_at
   column :created_at
   column :updated_at 
   actions
  end
  
  form do |f|
    f.inputs "User Details" do
      f.input :firstName
      f.input :lastName
      f.input :email
      f.input :role_id
      f.input :password
    end
    f.actions
  end

   permit_params :firstName, :lastName, :email, :role_id, :password
end
