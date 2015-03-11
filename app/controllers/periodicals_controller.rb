class PeriodicalsController < ApplicationController
  def show_all_periodical
    render plain: Periodical.all.inspect
  end
  def show_periodical
    
  end
end
