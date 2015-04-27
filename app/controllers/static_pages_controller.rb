class StaticPagesController < ApplicationController

  def home
    @events = Event.all
    
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end

  def about
  end

  def contact
  end

  def learn
	end
end
