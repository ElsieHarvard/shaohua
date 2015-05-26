class WebAccountsController < ApplicationController
	STDADMIN="elsie"
	def login_check # !!!!!! Very Unsafe !!!!!!
		raise 'STOP' unless firewall(params[:usrinfo][:usrname])==STDADMIN
		usr=WebAccounts.find_by(usrname: firewall(params[:usrinfo][:usrname]))
		if usr
			pas=firewall(params[:usrinfo][:usrpassword])
			slt=usr.password_salt.unpack('m')[0]
			itr=(usr.usrtype=='admin' ? 65536 : 16384)
			psh=usr.usrpasswordhash
			hsh=[OpenSSL::PKCS5.pbkdf2_hmac(pas,slt,itr,512,OpenSSL::Digest::SHA512.new)].pack('m')
			if psh == hsh
				cookies.signed[:webuser]={:value=>usr.usrhash,:domain=>"12shaohua.oicp.net"}
				LOGIN_LOG.info("User: "+usr.usrhash+"{"+usr.usrname+"} LogIn!\n")
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
