class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :authenticate_user!, except: [:show, :index]
  
  def show
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @question = Question.new(question_params)

    if !Obscenity.profane?(@question.content) && !Obscenity.profane?(@question.title)
      if @question.save
        flash[:success] = "Thank you for posting on the forum!"
        redirect_to @question
      else
        flash[:danger] = "Error, please try again."
        render :new
      end
    else
      flash[:danger] = "Explicit content detected, no foul language please!"
      render :new
    end
  end

  def edit
    if current_user != @question.user
      flash[:danger] = "You are not authorized to edit this question."
      redirect_to request.referrer
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @question.update(question_params) && !Obscenity.profane?(@question.content) && !Obscenity.profane?(@question.title)
      flash[:success] = "Question updated successfully."
      redirect_to @question
    else
      if Obscenity.profane?(@question.content) || Obscenity.profane?(@question.title)
        flash[:danger] = "Explicit content detected, no foul language please!"
        render :edit
      else
        flash[:danger] = "Question was not updated."
        render :edit
      end
    end
  end

  def destroy
    if current_user = @question.user
      @question.destroy
      flash[:success] = "The question titled '#{@question.title}' has been destroyed"
      redirect_to request.referrer
    else
      flash[:danger] = "You are not authorized to delete this question."
      redirect_to @question
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :category, :user_id, :posted)
    end

    def set_question
      @question = Question.find(params[:id])
    end

    def set_user
      @user = current_user
    end
end
