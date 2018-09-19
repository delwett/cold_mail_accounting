class LettersController < ApplicationController
  def index
    @letters = Letter.all
  end

  def show

  end

  def new
    @letter = Letter.new
  end

  def create
    @letter = Letter.new(letter_params)

    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
   def letter_params
     params.require(:letter).permit(:url, :email, :comment).merge!(user_id: current_user.id)
   end

end
