class HomeController < ApplicationController
  def index
    @events = Event.ordered_by_published_at
  end

  def about
  end
end
