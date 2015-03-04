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
  def navlogin
    if (usracc=WebAccount.find_by(usrhash:cookies.signed[:webuser]) rescue nil)
      return 'web_global/user_account',usracc
    else
      return 'web_global/login',nil
    end
  end
  def raise404
    
  end
end
