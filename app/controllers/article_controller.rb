class ArticleController < ApplicationController
  before_filter :authenticate_shell_user!, only: [
    :create_new_article,
    :request_new_article,
    :edit_single_article,
  ]
  def show_all_articles
    render({
      :template => 'article/show_all_articles',
      :locals => {:data => Article.export_article_list}
    })
  end
  def show_single_article
    article = Article.find_by idhsh:parahsh(true)
    render({:template => 'article/show_single_article', :locals => {:arc => article}})
  end
end
