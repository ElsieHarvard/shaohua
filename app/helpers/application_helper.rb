module ApplicationHelper
  def title(page_title)
    content_for(:title){page_title}
  end
  def mkhsh(src)
  	Digest::SHA1.hexdigest src
  end
  def web_local_head_img_src(src)
  	content_for(:web_local_head_img_src){src}
  end
end
