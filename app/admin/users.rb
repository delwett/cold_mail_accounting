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

  show do
    attributes_table do
      row :email
      row :encrypted_password
      row :user_name
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :created_at
      row :updated_at
    end
    div do
      form action: send_mail_admin_user_path, method: :get do |f|
        f.input :message_field, type: :text, name: 'message_field'
        f.input :submit, type: :submit
      end
    end
  end
  member_action :send_mail, method: :get do
    SendEmailJob.set(wait: 10.seconds).perform_later(resource.email, params[:message_field])
    redirect_to admin_users_path
  end


  form do |form|
    inputs I18n.t(:fill_field_lable) do
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
