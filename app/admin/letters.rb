ActiveAdmin.register Letter do

  scope :all, default: true, group: :status
  scope I18n.t(:new), :new_letters, group: :status
  scope I18n.t(:in_progress), :in_progress_letters, group: :status
  scope I18n.t(:completed), :completed_letters, group: :status
  scope I18n.t(:cancelled), :cancelled_letters, group: :status

  filter :user
  filter :url
  filter :email
  filter :comment
  filter :created_at
  filter :updated_at
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
