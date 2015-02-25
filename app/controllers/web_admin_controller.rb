class WebAdminController < ApplicationController
  def sudo_sign_up_debug
    @weblayoutadmin=true
  end
  def sudo_create_user_debug
    @weblayoutadmin=true
    unless WebAccount.find_by usrname: WebAccount.firewall(params[:usrinfo][:usrname])
      @account=WebAccount.createnew(params[:usrinfo][:usrname],params[:usrinfo][:usrpassword],params[:usrinfo][:usrtype])
      @account.save
    else
      @alert='ERROR: User Already Exist'
    end
  end
end
