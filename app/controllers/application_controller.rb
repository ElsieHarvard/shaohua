class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Parameter Hash
  def parahsh( raise_400 = false )
    hsh = params[:idhsh]
    return hsh if /\A\h{56}\z/.match hsh
    raise '400' if raise_400
  end
end
