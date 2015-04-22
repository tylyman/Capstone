class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :vote]
  before_action :set_question, except: :vote
  before_action :set_user
  before_action :authenticate_user!, except: [:show, :index]

  def show
  end

  def new
    @answer = @question.answers.build

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      flash[:success] = "Response posted successfully."
      render :js => "window.location = '#{request.referrer}'"
    else
      render :new
    end
  end

  def edit
    if current_user != @answer.user
      flash[:danger] = "You are not authorized to edit this response."
      render :js => "window.location = '#{request.referrer}'"
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def update
    if current_user == @answer.user
      if @answer.update(answer_params)      
        flash[:success] = "Response updated successfully."
        render :js => "window.location = '#{request.referrer}'"
      else
        render :edit
      end
    else
      flash[:danger] = "You are not authorized to edit this response."
      render :js => "window.location = '#{request.referrer}'"
    end
  end

  def destroy
    if current_user == @answer.user
      @answer.destroy
      flash[:success] = "The response has been destroyed"
      redirect_to @answer.question
    else
      flash[:danger] = "You are not authorized to delete this response."
      redirect_to @answer.question
    end
  end

  def vote
    if @answer.voters.include?(current_user.id)
      flash[:danger] = "You can only vote once."
      redirect_to @answer.question
    else
      @answer.voters.push(current_user.id)
      if params[:vote] == "up"
        @answer.upvote
      elsif params[:vote] == "down"
        @answer.downvote
      end

      respond_to do |format|
        format.html { redirect_to @answer.question }
        format.js 
      end
    end      
  end

  private    
    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id, :helpful)
    end
    
    def set_user
      @user = current_user
    end
    
    def set_question 
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end
end
