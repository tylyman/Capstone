class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_question
  before_action :set_user
  before_action :authenticate_user!, except: [:show, :index]
  
  def show
  end

  def index
    @answers = Answer.all
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      flash[:success] = "Answer created successfully."
      redirect_to request_referrer
    else
      flash[:danger] = "Error-Answer was not created."
      render :new
    end
  end

  def edit
    if current_user != @answer.user
      flash[:danger] = "You are not authorized to edit this answer."
      redirect_to request.referrer
    end
  end

  def update
    if @answer.update(question_params)
      flash[:success] = "Answer updated successfully."
      redirect_to @question
    else
      flash[:danger] = "Answer was not updated."
      render :edit
    end
  end

  def destroy
    if current_user = @answer.user
      @answer.destroy
      flash[:success] = "The selected answer has been destroyed"
      redirect_to request.referrer
    else
      flash[:danger] = "You are not authorized to delete this answer."
      redirect_to @question
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
      @question = Question.find(params[:id])
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end
end
