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

    if !Obscenity.profane?(@answer.content)
      if @answer.save
        flash[:success] = "Answer created successfully."
        render :js => "window.location = '#{request.referrer}'"
      else
        flash[:danger] = "Error-Answer was not created."
        render :new
      end
    else
      flash[:danger] = "Explicit content detected, no foul language please!"
      render :new
    end
  end

  def edit
    if current_user != @answer.user
      flash[:danger] = "You are not authorized to edit this answer."
      render :js => "window.location = '#{request.referrer}'"
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def update
    if @answer.update(answer_params) && !Obscenity.profane?(@answer.content)
      flash[:success] = "Answer updated successfully."
      redirect_to @answer.question
    else
      if Obscenity.profane?(@answer.content)
        flash[:danger] = "Explicit content detected, no foul language please!"
        render :edit
      else
        flash[:danger] = "Answer was not updated."
        render :edit
      end
    end
  end

  def destroy
    if current_user = @answer.user
      @answer.destroy
      flash[:success] = "The selected answer has been destroyed"
      redirect_to @answer.question
    else
      flash[:danger] = "You are not authorized to delete this answer."
      redirect_to @answer.question
    end
  end

  def vote
    if params[:vote] == "up"
      @answer.upvote
    elsif params[:vote] == "down"
      @answer.downvote
    end  

    respond_to do |format|
      format.html { redirect_to @answer }
      format.js 
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
