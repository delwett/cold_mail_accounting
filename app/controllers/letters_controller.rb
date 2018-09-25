class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update]
  def index
    @letters = current_user.letters
  end

  def show; end

  def new
    @letter = Letter.new
  end

  def create
    @letter = current_user.letters.build(letter_params)
    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: t(:notice_created)}
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    @letter.update(letter_params.except(:letter_status))
    respond_to do |format|
      if @letter.save
        set_status_from_params
        format.html { redirect_to @letter, notice: t(:notice_updated)}
      else
        format.html { render :edit }
      end
    end
  end

  def search
    to = params[:to].to_date || Date.today
    from = params[:from].to_date || to - 1.month
    stat = if params[:stat] == ''
             Letter.aasm.states.map(&:name)
           else
             params[:stat]
           end
    @letters = current_user.letters.where(created_at: from..to, letter_status: stat)
    respond_to do |format|
      format.js { render :search, layout: false }
    end
  end

  private

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

  def set_letter
    @letter = current_user.letters.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to letters_path, notice: t(:notice_error_id)
  end

end
