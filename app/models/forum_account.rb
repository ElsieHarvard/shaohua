class ForumAccount < ActiveRecord::Base
  Default_Marshal_Info = ''
  Default_Formatted_Info = ''
  acts_as_taggable_on :tags
  # Make id-hash before create
  before_create :make_id_hash
  def chkidhsh
    make_id_hash
  end
  private
  def refresh_idhsh
    make_id_hash
    self.save
  end
  def make_id_hash
    self.idhsh = SHA3::Digest::SHA224.hexdigest self.usr_name+self.ext_shell_idhsh
  end
end
