class ArticlesController < ApplicationController
  def new_article
    
  end
  def create_article
    @article = firewall_article(Article.new(firewall_create_article_params))
    @article.makeuparc
    render plain: params.inspect+"\n"+@article.inspect+"\n"+@article.arccontent.inspect
  end
  private
  def firewall_create_article_params
    return params.require(:article).permit(:arctitle,:arcauthor,:arctype,:arccontent)
  end
  def firewall_article(article)
    # Nothing...
    return article
  end
end
