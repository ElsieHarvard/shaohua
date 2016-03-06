class Article < ActiveRecord::Base
  acts_as_taggable_on :tags
  # Make id-hash before create
  before_create :make_id_hash
  before_save :make_id_hash
  # Refresh All Hash (Must be Executed after manually modified Database)
  def self.refresh_idhsh
    Article.all.each{|arc|arc.save}
  end
  # Push Subheading to content
  def self.push_subheading_to_content
    Article.all.each{|arc|
      m, s = arc.arc_title.split('——')
      if s
        arc.arc_title = m
        arc.arc_content = s + "\n" + arc.arc_content
        arc.save
      end
    }
  end
  # Export article list
  def self.export_article_list
    Article.all.collect{|arc|
      {
        :title => arc.arc_title,
        :idhsh => arc.idhsh,
        :ext_author_idhsh => arc.ext_author_idhsh,
        :usr_name => arc.arc_author.usr_name,
        :content => arc.arc_content[0..29].split("img:")[0],
        :tag => arc.tag_list.inspect,
        :path => arc.canonical_url,
      }
    }
  end
  # Add Author
  def add_author(author)
    account = ForumAccount.find_by usr_name: author
    if account.nil?
      f = ForumAccount.new
      f.ext_shell_idhsh = 'system'
      f.usr_name = ''.html_safe.concat author
      f.marshal_info_hash = ForumAccount::Default_Marshal_Info
      f.formatted_information = ForumAccount::Default_Formatted_Info
      f.save if ForumAccount.find_by(idhsh:f.chkidhsh) == nil
      account = f
    end
    self.ext_author_idhsh = account.idhsh
  end
  # Get Author
  def arc_author
    author_id = self.ext_author_idhsh
    rst = ForumAccount.find_by( idhsh: author_id ) if author_id != nil
    raise "DataError: #{ self.idhsh } " if rst.nil?
    return rst
  end
  # Check Article Hash
  def chkidhsh
    make_id_hash
  end
  private
  def make_id_hash
    self.idhsh = SHA3::Digest::SHA224.hexdigest self.arc_content
  end
end
