class PeriodicalsController < ApplicationController
  def show_all_periodical
    render plain: Periodical.all.inspect # debug
  end
  def show_periodical
    
  end
  def new_periodical
    return unless need_login
  end
  def create_periodical
    return unless need_login
    prd=Periodical.new(params.require(:periodical).permit(:prdtitle,:prdinfo,:prdmsg,:prdpages,:prdno))
    prd.mkhsh
    unless Periodical.exists?(prdhash:prd.prdhash)
    	prd.save
    else
    	prd PeriodicalArticle.find_by(archash:arc.archash)
    end
    # render plain:prd.inspect+"\n"+params.inspect
    # redirect_to prd
  end
end
