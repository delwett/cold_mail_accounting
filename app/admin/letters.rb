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

  form do |form|
    inputs I18n.t(:fill_field_lable) do
      input :user, collection: User.all.map { |usr| [usr.user_name, usr.id] }
      input :url
      input :email
      if object.persisted? && available_event
        input :letter_status, collection: available_states.collect { |av| [t(av), av] }
      else
        li t(:status_label, status: t(resource.letter_status))
      end
      input :comment
      actions
    end
  end
  action_item :back_to_index, only: %i[show edit new] do
    link_to(I18n.t(:back), admin_letters_path)
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
      params.require(:letter).permit(:user_id, :url, :email, :comment, :letter_status)
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

    def available_event
      resource.aasm.events(permitted: true).map(&:name).any?
    end

    def available_states
      @letter.aasm.events(permitted: true).map(&:name) << @letter.letter_status
    end
  end

end
