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

    if @question.save
      flash[:success] = "Thank you for posting on the forum!"
      render :js => "window.location = '#{request.referrer}'"
    else
      render :new
    end
  end

  def edit
    if current_user == @question.user || current_user.admin?
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "You are not authorized to edit this post."
      redirect_to @question
    end
  end

  def update
    if current_user == @question.user || current_user.admin?
      if @question.update(question_params)
        flash[:success] = "Post updated successfully."
        render :js => "window.location = '#{request.referrer}'"
      else
        render :edit
      end
    else  
      flash[:danger] = "You are not authorized to edit this post."
      redirect_to @question
    end
  end

  def destroy
    if current_user == @question.user || current_user.admin?
      @question.destroy
      flash[:success] = "The post titled '#{@question.title}' has been destroyed"
      redirect_to questions_path
    else
      flash[:danger] = "You are not authorized to delete this post."
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
