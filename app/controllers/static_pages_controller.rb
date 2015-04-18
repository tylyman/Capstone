class StaticPagesController < ApplicationController

  def home
    @events = Event.all
  end

  def about
  end

  def contact
  end

  def learn
	end
end
