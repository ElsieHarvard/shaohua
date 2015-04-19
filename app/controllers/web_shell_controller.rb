class WebShellController < ApplicationController
  def index
  	@homepage=true
  end
  def about
  end
  def bbs
    
  end
  def bbs_usr
    if /\h{39}/.match params[:hash]
      @artc=[]
      Article.all.each { |e| @artc.push e if Digest::SHA1.hexdigest(e.arcauthor) == params[:hash] }
      @arca=@artc[0].arcauthor
    else
      raise 'BadAuthorHash'
    end
  end

end
