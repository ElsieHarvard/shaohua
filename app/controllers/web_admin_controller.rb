class WebAdminController < ApplicationController
  def sudo_sign_up_debug
    return unless need_login 'admin'
    @weblayoutadmin=true
  end
  def sudo_create_user_debug
    return unless need_login 'admin'
    @weblayoutadmin=true
    unless WebAccount.find_by usrname: WebAccount.firewall(params[:usrinfo][:usrname])
      @account=WebAccount.createnew(params[:usrinfo][:usrname],params[:usrinfo][:usrpassword],params[:usrinfo][:usrtype])
      @account.save
    else
      @alert='ERROR: User Already Exist'
      @account=(WebAccount.find_by usrname: WebAccount.firewall(params[:usrinfo][:usrname])) 
    end
  end
  def refresh_archash
    return unless need_login 'admin'
    @weblayoutadmin=true
    Article.all.each{|w|w.update :archash=>w.makeuparc}
  end
end
