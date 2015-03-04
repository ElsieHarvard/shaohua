class WebGlobalController < ApplicationController
  def mainsite_navigator
  end
  def usrlogin # Very Unsafe
    usr=WebAccount.find_by(usrname: firewall(params[:usrinfo][:usrname]))
    if usr
      pas=firewall(params[:usrinfo][:usrpassword])
      slt=usr.password_salt.unpack('m')[0]
      itr=(usr.usrtype=='admin' ? 65536 : 16384)
      psh=usr.usrpasswordhash
      hsh=[OpenSSL::PKCS5.pbkdf2_hmac(pas,slt,itr,512,OpenSSL::Digest::SHA512.new)].pack('m')
      if psh == hsh
        cookies.signed[:webuser]=usr.usrhash
        render plain: 'true'
      else
        render plain: 'false'
      end
    else
      render plain: 'false'
    end
  end
  def publickey
    return OpenSSL::PKey::RSA.new 
  end
  private
  def firewall(src)
    return src.gsub(/\W/,'')
  end
  def firewall_hex(src)
    return src.gsub(/\H/,'')
  end
end
