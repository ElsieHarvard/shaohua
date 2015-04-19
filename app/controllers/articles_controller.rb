class ArticlesController < ApplicationController
  def show_all_article
    @articles=Article.all
  end
  def new_article
    return unless need_login
  end
  def advanced_new_article
    return unless need_login
  end
  def create_advanced_new_article
    return unless need_login
    picmime=File.extname(params[:article][:arcpicture].tempfile)
    arc=PeriodicalArticle.new params.require(:article).permit(:arctitle,:arcpreauthor,:arcauthor,:arcnumber,
      :arcbeforecontent,:arcattrbeforecontent,:arccontent,:arcattraftercontent,:arcaftercontent,:prdhash)
    pic=File.open(params[:article][:arcpicture].tempfile,'rb'){|w|w.read}
    arc.arcphsh pic
    arc.mkhsh
    unless PeriodicalArticle.exists?(archash:arc.archash)
      arc.save
    else
      arc=PeriodicalArticle.find_by(archash:arc.archash)
    end
    File.open("./public/periodical/img/"+arc.archash+picmime, "wb"){|f|
      f.write pic}
    #render plain:arc.inspect+"\n"+params.inspect
    redirect_to arc
  end
  def show_article
    if ["prose","novel","poetry","drama"].include? params[:hash]
      render :template=>'articles/show_article_list',
             :locals=>{:hctitle=>{"prose"=>"散文类","novel"=>"小说类","poetry"=>"诗歌类","drama"=>"戏剧类"}[params[:hash]],
                       :list=>Article.where(arctype: 'db.'+params[:hash]),:pagetit=>true}
    elsif /\h{64}/.match params[:hash]
      if PeriodicalArticle.exists?(:archash=>params[:hash].downcase)
        @article = PeriodicalArticle.find_by(archash:params[:hash].downcase)
        @periodical=true
        # render plain: @article.inspect # debug
      else
        raise404
      end
    elsif /\h{39}/.match params[:hash]
      if Article.exists?(:archash=>params[:hash].downcase)
        @article = Article.arcfind(params[:hash].downcase)
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
    return unless need_login
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
    return unless need_login
  end
  def update_article
    return unless need_login
    @article = Article.arcfind(params[:article][:archash].downcase)
    unless @article.nil?
      need_login(@article.arcauthor)
      @article.update firewall_edit_article_params
      @article.makeuparc
      @article.update({:arctitle=>@article.arctitle,:arcauthor=>@article.arcauthor,:arccontent=>@article.arccontent})
      Analysis.find_by(arcid:@article.id).update(arctype:@article.arctype)
    else
      raise 'BadArticleHash'
    end
    redirect_to @article
  end
  def top_an_article
    raise 'BadArticleHash' unless /\h{39}/.match params[:archsh]
    return render plain: '您已经赞过啦！' if (cookies['toped'+params[:archsh]]=='1' )
    if Article.exists?(:archash=>params[:archsh].downcase)
      @article = Article.arcfind(params[:archsh].downcase)
      ana=Analysis.find_by(arcid:@article.id)
      ana.update(:arcview=>ana.arcview+1)
      cookies['toped'+params[:archsh]]='1'
      render plain: ana.arcview.inspect
    else
      raise404
    end    
  end
  private
  def periodical_article_url(arc)
    return arc.archash
  end
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
