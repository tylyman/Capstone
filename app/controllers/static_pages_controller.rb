class StaticPagesController < ApplicationController

  def home
    @events = Event.all
    @event = Event.find(params[:id])
    
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end

    @mylat = @event.latitude
    @mylong = @event.longitude
  end

  def about
  end

  def contact
  end

  def learn
	end
end
