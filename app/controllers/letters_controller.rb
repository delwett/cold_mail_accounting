class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update]
  def index
    @letters = Letter.all
  end

  def show

  end

  def new
    @letter = Letter.new
  end

  def create
    @letter = current_user.letters.build(letter_params)
    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @edit_status = true
  end

  def update
    @letter.update(letter_params.except(:letter_status))
    respond_to do |format|
      if @letter.save
        set_status_from_params
        format.html { redirect_to @letter, notice: 'Letter was successfully updated.' }
      else
        @edit_status = true
        format.html { render :edit }
      end
    end
  end

  private
   def letter_params
     params.require(:letter).permit(:url, :email, :comment, :letter_status)
   end

  def set_status_from_params
    case params[:letter][:letter_status]
    when 'to_in_progress'
      @letter.to_in_progress!
    when 'to_completed'
      @letter.to_completed!
    when 'to_cancelled'
      @letter.to_cancelled!
    end
  end

  def set_letter
    @letter = Letter.find(params[:id])
  end

end
