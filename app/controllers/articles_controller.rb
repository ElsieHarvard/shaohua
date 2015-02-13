class ArticlesController < ApplicationController
  def show_all_article
    @articles=Article.all
  end
  def new_article
  end
  def show_article
    @article = Article.arcfind(params[:hash])
    render plain: @article.inspect # debug
  end
  def create_article
    @article = firewall_article(Article.new(firewall_create_article_params))
    @article.makeuparc
    arc = Article.arcfind(@article.archash)
    unless arc.nil?
      @article = arc
    else
      @article.save
    end
    redirect_to @article
  end
  private
  def article_url(arc)
    return arc.archash
  end
  def firewall_create_article_params
    return params.require(:article).permit(:arctitle,:arcauthor,:arctype,:arccontent)
  end
  def firewall_article(article)
    unless["db.unsessioned",
           "db.tanyoulunjin",
           "db.fushengsanji",
           "db.suosiwuxie",
           "db.shoubushijuan",
           "db.qingchunshiyi",
           "db.qianzhendichang"].include? article.arctype
      raise 'BadArticleType'
    end
    return article
  end
end
