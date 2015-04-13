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
      flash[:danger] = "Error.  Answer was not created."
      render :new
    end
  end

  def edit
    
  end

  def update
  
  end

  def destroy
  
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
