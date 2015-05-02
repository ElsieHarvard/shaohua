class ArticlesController < ApplicationController
	def show_all_article
		@articles=Article.all
	end
	def new_article
		return unless need_login
		@arc=Article.new
	end
	def edit_article
		return unless need_login
		if /\A\h{40}\Z/.match params[:hash]
			if Article.exists?(:arc_hash=>params[:hash].downcase)
				@arc = Article.find_by(arc_hash:params[:hash].downcase)
			else
				return raise404
			end
		else
			return raise404
		end
	end
	def show_article
		if ["prose","novel","poetry","drama"].include? params[:hash]
			render :template=>'articles/show_article_list',
						 :locals=>{:hctitle=>{"prose"=>"散文类","novel"=>"小说类","poetry"=>"诗歌类","drama"=>"短剧类"}[params[:hash]],
											 :list=>Article.where(arc_type: 'db.'+params[:hash]),:pagetit=>true}
		elsif /\A\h{40}\Z/.match params[:hash]
			if Article.exists?(:arc_hash=>params[:hash].downcase)
				@article = Article.find_by(arc_hash:params[:hash].downcase)
				@article.update(:arc_view=>@article.arc_view+1)
			else
				return raise404
			end
		else
			return raise404
		end
	end
	def top_of_article
		raise404 unless /\A\h{40}\z/.match params[:hash]
		if Article.exists?(:arc_hash=>params[:hash].downcase)
			arc=Article.find_by(:arc_hash=>params[:hash].downcase)
		else
			raise404
		end
		return render plain:"<button class=\"btn btn-info\" onclick=\"return arctotop();\" id=\"topanarc\" archsh="+params[:hash].downcase+
		       ">赞："+arc.arc_top.to_s+"</button>"+"<button class=\"btn btn-default\">浏览："+arc.arc_view.to_s+"</button>"
	end
	def create_advanced_new_article
		return unless need_login
		picmime=File.extname(params[:article][:arcpicture].tempfile)
		arc=Article.new params.require(:article).permit(:arctitle,:arcpreauthor,:arcauthor,:arcnumber,:arctype,
			:arcbeforecontent,:arcattrbeforecontent,:arccontent,:arcattraftercontent,:arcaftercontent,:prdhash)
		pic=File.open(params[:article][:arcpicture].tempfile,'rb'){|w|w.read}
		arc.arcphsh pic
		arc.mkhsh
		unless Article.exists?(archash:arc.archash)
			arc.save
		else
			arc=Article.find_by(archash:arc.archash)
		end
		File.open("./public/periodical/img/"+arc.archash+picmime, "wb"){|f|f.write pic}
		redirect_to arc
	end
end
