class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :edit, :destroy, :enroll]
  before_action :set_user

  def new
    @event = @user.events.build
  end

  def create
    @event = Event.new(event_params)
    @event.owner = events_owner
    if @event.save
      redirect_to events_path
    else
      flash[:danger] = "You did not create this event"
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
    if @event.owner == current_user
      @event.destroy
      flash[:success] = "The Event was destroyed"
      redirect_to events_path
    else
      flash[:danger] = "You are not authorized to delete this event."
      redirect_to @event
    end
  end

  def show 
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @events = Event.all
  end

  def enroll
    @event.users << @user
    if @event.valid?
      redirect_to root_path
      flash[:success] = "You are enrolled in #{@event.title}"
    else
      @event.users.delete @user
      redirect_to root_path
      flash[:danger] = @event.errors.full_messages
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :datetime, :city, :state, :cost, :vacancies, :user_id, :total_spots)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def events_owner
    @events_owner = current_user
  end
end
