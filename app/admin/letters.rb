ActiveAdmin.register Letter do

  scope -> { I18n.t(:all) }, :all, default: true
  scope -> { I18n.t(:new) }, :new_letters, group: :status
  scope -> { I18n.t(:in_progress) }, :in_progress_letters, group: :status
  scope -> { I18n.t(:completed) }, :completed_letters, group: :status
  scope -> { I18n.t(:cancelled) }, :cancelled_letters, group: :status

  filter :user
  filter :url
  filter :email
  filter :comment
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :user do |letter|
      letter.user.email.truncate(15)
    end
    column :url do |letter|
      letter.url.truncate(15)
    end
    column :email do |letter|
      letter.email.truncate(15)
    end
    column :letter_status
    column :comment do |letter|
      letter.comment.truncate(30)
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :user
      row :url
      row :email
      row :letter_status do |letter|
        I18n.t(letter.letter_status)
      end
      row :comment
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

# See permitted phttp://0.0.0.0:3000/admin/letters?scope=allarameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
