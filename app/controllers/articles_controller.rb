class ArticlesController < ApplicationController
  def show_all_article
    @articles=Article.all
  end
  def new_article
  end
  def show_article
    if ["prose","novel","poetry","drama"].include? params[:hash]
      render :template=>'articles/show_article_list',
             :locals=>{:hctitle=>{"prose"=>"散文类","novel"=>"小说类","poetry"=>"诗歌类","drama"=>"戏剧类"}[params[:hash]],
                       :list=>Article.where(arctype: 'db.'+params[:hash]),:pagetit=>true}
    elsif /\h{39}/.match params[:hash]
      if Article.exists?(:archash=>params[:hash].downcase)
        @article = Article.arcfind(params[:hash].downcase)
        ana=Analysis.find_by(arcid:@article.id)
        ana.update(:arcview=>ana.arcview+1)
        # render plain: @article.inspect # debug
      else
        raise404
      end
    else
      raise 'BadArticleHash'
    end
  end
  def show_author
    if /\h{39}/.match params[:hash]
      render plain: params.inspect # debug
    else
      raise 'BadArticleHash'
    end      
  end
  def create_article
    @article = firewall_article(Article.new(firewall_create_article_params))
    @article.makeuparc
    arc = Article.arcfind(@article.archash)
    unless arc.nil?
      @article = arc
    else
      @article.save
      Analysis.new(:arcid=>@article.id,:arcview=>0,:arctag=>'',:arctype=>@article.arctype).save
    end
    redirect_to @article
  end
  def edit_article
  end
  def update_article
    @article = Article.arcfind(params[:article][:archash].downcase)
    unless @article.nil?
      @article.update firewall_edit_article_params
      @article.makeuparc
      @article.update({:arctitle=>@article.arctitle,:arcauthor=>@article.arcauthor,:arccontent=>@article.arccontent})
      Analysis.find_by(arcid:@article.arcid).update(arctype:@article.arctype)
    else
      raise 'BadArticleHash'
    end
    redirect_to @article
  end
  private
  def article_url(arc)
    return arc.archash
  end
  def firewall_edit_article_params
    unless ["db.prose","db.novel","db.poetry","db.drama"].include? params[:article][:arctype]
      raise 'BadArticleType'
    end
    return params.require(:article).permit(:arctitle,:arcauthor,:arctype,:arccontent)
  end
  def firewall_create_article_params
    return params.require(:article).permit(:arctitle,:arcauthor,:arctype,:arccontent)
  end
  def firewall_article(article)
    unless ["db.prose","db.novel","db.poetry","db.drama"].include? article.arctype
      raise 'BadArticleType'
    end
    return article
  end
end
