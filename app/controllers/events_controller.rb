class EventsController < ApplicationController
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
    @event = Event.find(params[:id])
    if @event.user != current_user
      redirect_to @event, notice: "You are not authorized to edit this event."
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user != current_user
      redirect_to @event, notice: "You are not authorized to delete this event."
    else
    @event.destroy
    redirect_to users_show_path
    end
  end

  def show
    @event = Event.find(params[:id]) 
  end

  def index
    @events = Event.all
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :datetime, :city, :state, :cost, :vacancies, :created_at, :updated_at)
  end
end
