class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :edit, :destroy]
  before_action :set_user
  
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      redirect_to :new
    end
  end

  def edit
    unless @event.users.include?(current_user)
      redirect_to @event, notice: "You are not authorized to edit this event."
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    if current_user == @event.users
      @event.destroy
      flash[:success] = "The Event was destroyed"
      redirect_to events_path
    else
      flash[:danger] = "You are not authorized to delete this event."
      redirect_to @event
    end
  end

  def show 
  end

  def index
    @events = Event.all
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :datetime, :city, :state, :cost, :vacancies, :user_id)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
