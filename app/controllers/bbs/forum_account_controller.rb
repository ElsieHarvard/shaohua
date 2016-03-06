class Bbs::ForumAccountController < ApplicationController
  before_filter :authenticate_shell_user!
  def create_new_account
    f = ForumAccount.new
    f.ext_shell_idhsh = current_shell_user.idhsh
    f.usr_name = ''.html_safe.concat params[:account][:usr_name]
    f.marshal_info_hash = ForumAccount::Default_Marshal_Info
    f.formatted_information = ForumAccount::Default_Formatted_Info
    f.save if ForumAccount.find_by(idhsh:f.chkidhsh) == nil
    redirect_to bbs_local_path
  end
end
