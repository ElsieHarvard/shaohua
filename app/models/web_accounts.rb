class WebAccounts < ActiveRecord::Base
	#!DEBUG-ONLY!#
	def self.createnew(name,pswd,type)
		return self.new.initset(self.firewall(name),self.firewall(type),self.firewall(pswd))
	end
	def initset(un,ut,up)
		write_attribute :usrname,un
		write_attribute :usrtype,ut
		slt=OpenSSL::Random.random_bytes(512)
		write_attribute :password_salt,[slt].pack('m')
		write_attribute :usrpasswordhash,[mkhsh(up,slt,ut=='admin' ? 65536 : 16384 )].pack('m')
		write_attribute :usrhash,OpenSSL::Digest::SHA512.hexdigest(usrname)
		return self
	end
	private
	def self.firewall(src)
		return src.gsub(/\W/,'')
	end
	def mkhsh(pass,salt,iter)
		OpenSSL::PKCS5.pbkdf2_hmac(pass, salt, iter, 512, OpenSSL::Digest::SHA512.new)
	end
end
