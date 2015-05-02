class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def need_login(cmd=nil)
    if (WebAccounts.find_by(usrhash:cookies.signed[:webuser]) rescue nil)
      return true
    else
      render :template=>'web_shell/needlogin'
      return false
    end
  end
  def raise404
    return render :template=>"web_shell/404",:status=>404
  end
end
