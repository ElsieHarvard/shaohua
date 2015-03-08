class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def need_login(cmd=nil)
    if (WebAccount.find_by(usrhash:cookies.signed[:webuser]) rescue nil)
      return true
    else
      render :template=>'web_global/needlogin'
      return false
    end
  end
  def raise404
    render :plain=>"", :status=>404
  end
end
