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
      letter.url.truncate(25)
    end
    column :email do |letter|
      letter.email.truncate(15)
    end
    column :letter_status do |letter|
      I18n.t(letter.letter_status)
    end
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
  end

  controller do
    def update
      resource.update(letter_params.except(:letter_status))
      respond_to do |format|
        if resource.save
          set_status_from_params
          format.html { redirect_to admin_letter_path(resource) }
        else
          format.html { render :edit }
        end
      end
    end

    def letter_params
      params.require(:letter).permit(:url, :email, :comment, :letter_status)
    end

    def set_status_from_params
      case letter_params[:letter_status]
      when 'to_in_progress'
        @letter.to_in_progress!
      when 'to_completed'
        @letter.to_completed!
      when 'to_cancelled'
        @letter.to_cancelled!
      end
    end
  end

end
