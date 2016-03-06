module ApplicationHelper
  # Set Page Title
  def title(page_title=nil, ext_title=nil)
    ext_title = I18n.t 'title' if ext_title.nil?
    page_title = page_title.nil? ? "" : page_title + ' - '
    content_for(:title){ page_title + ext_title }
  end
end
