ActiveAdmin.register User do

  filter :email
  filter :user_name
  filter :created_at
  filter :updated_at

  permit_params :email, :user_name, :password

  index do
    selectable_column
    column :id
    column :email
    column :user_name
    column :created_at
    column :updated_at
    actions
  end


  form do |form|
    inputs I18n.t(:fill_field_lable) do
      # binding.pry
      input :email
      input :user_name
      input :password
      actions
    end
  end

  action_item :back_to_index, only: %i[show edit new] do
    link_to(I18n.t(:back), admin_users_path)
  end
end
