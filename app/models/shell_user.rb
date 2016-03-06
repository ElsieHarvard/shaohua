class ShellUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable
  # Make id-hash before create
  before_create :make_id_hash
  private
  def make_id_hash
    self.idhsh = SHA3::Digest::SHA224.hexdigest self.email+OpenSSL::Random.random_bytes(4096)
  end
end
