module ApplicationHelper
  def title(page_title)
    content_for(:title){page_title}
  end
  def mkhsh(src)
  	Digest::SHA1.hexdigest src
  end
end
