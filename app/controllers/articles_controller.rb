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
				cookies[:hash] = "visited;" if cookies[:hash].nil? or cookies[:hash].empty?
				@article.update(:arc_view=>(@article.arc_view.nil? ? 0 : @article.arc_view)+1)
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
			cookies[:hash] = "visited;" if cookies[:hash].nil? or cookies[:hash].empty?
		else
			raise404
		end
		return render plain:"<button class=\"btn btn-info\" onclick=\"return arctotop();\" id=\"topanarc\" archsh="+params[:hash].downcase+
		       ">赞："+(arc.arc_top.nil? ? Proc.new{arc.update(:arc_top=>0);next 0}.call.to_s : arc.arc_top.to_s)+"</button>"+"<button class=\"btn btn-default\">浏览："+arc.arc_view.to_s+"</button>"
	end
	def top_an_article
		raise404 unless /\A\h{40}\z/.match params[:hash]
		if Article.exists?(:arc_hash=>params[:hash].downcase)
			arc=Article.find_by(:arc_hash=>params[:hash].downcase)
			cookies[:hash] = "visited;" if cookies[:hash].nil? or cookies[:hash].empty?
			arc.update(:arc_top=>(arc.arc_top.nil? ? 1 : arc.arc_top+1)) unless cookies[:hash].include? "toped;"
			cookies[:hash] += "toped;"
			return render plain:"<button class=\"btn btn-info\" onclick=\"return arctotop();\" id=\"topanarc\" archsh="+params[:hash].downcase+
		       ">赞："+(arc.arc_top.nil? ? Proc.new{arc.update(:arc_top=>0);next 0}.call.to_s : arc.arc_top.to_s)+"</button>"+"<button class=\"btn btn-default\">浏览："+arc.arc_view.to_s+"</button>"
		else
			raise404
		end
	end
	def tag_of_article
		raise404 unless /\A\h{40}\z/.match params[:hash]
		if Article.exists?(:arc_hash=>params[:hash].downcase)
			arc=Article.find_by(:arc_hash=>params[:hash].downcase)
			cookies[:hash] = "visited;" if cookies[:hash].nil? or cookies[:hash].empty?
			tag_ary = ""
			arc.update(arc_tag:"") if arc.arc_tag.nil?
			arc.arc_tag.each_line{|w|
				tag_class,tag_content = w.split(";", 2)
				tag_ary.concat "<button class=\"btn "+tag_class+"\">"+tag_content.chomp+"</button>"+" "
			}
			ath = "<input type=\"hidden\" name="+request_forgery_protection_token.to_s.to_s+" value="+form_authenticity_token.to_s+">"
			metacode = "<input type=\"hidden\" name=\"hash\" value="+arc.arc_hash+">"
			inp = "<form class=\"form-horizontal\" id=\"cd-tag-new\" onsubmit=\"return tagadd();\" action=\"/article/tag/\" accept-charset=\"UTF-8\" method=\"post\">"+ath+metacode+tag_ary+"<div class=\"input-group\">"+"<input class=\"form-control\" id=\"inputTagName\" placeholder=\"新标签...\" required=\"required\" type=\"text\" name=\"taginfo[tagname]\"><span class=\"input-group-btn\"><button class=\"btn btn-default\" type=\"sumbit\">提交</button></span></div>"
			return render plain:inp+"</form>"
		else
			raise404
		end
	end
	def tag_an_article
		raise404 unless /\A\h{40}\z/.match params[:hash]
		if Article.exists?(:arc_hash=>params[:hash].downcase)
			arc=Article.find_by(:arc_hash=>params[:hash].downcase)
			cookies[:hash] = "visited;" if cookies[:hash].nil? or cookies[:hash].empty?
			arc.update(arc_tag:"")if arc.arc_tag.nil?
			thistag = string_firewall(params[:taginfo][:tagname])
			arc.update(arc_tag:arc.arc_tag+"btn-default;"+thistag+"\r\n")
			return render plain:arc.inspect
		else
			raise404
		end
	end
	def create_article
		return unless need_login
		arc=Article.new params.require(:article).permit(:arc_title,:arc_preauthor,:arc_author,:arc_number,:arc_type,
			:arc_beforecontent,:arc_attrbeforecontent,:arc_content,:arc_attraftercontent,:arc_aftercontent,:prdhash)
		begin
			picmime=File.extname(params[:article][:arc_picture].tempfile)
			pic=File.open(params[:article][:arc_picture].tempfile,'rb'){|w|w.read}
			arc.arcphsh pic
		rescue
		end
		unless Article.exists?(arc_hash:arc.arc_hash)
			arc.arc_tag = ""
			arc.arc_view = 0
			arc.arc_top = 0
			arc.save
		else
			arc=Article.find_by(arc_hash:arc.arc_hash)
		end
		begin
			File.open("./public/periodical/img/"+arc.arc_hash+picmime, "wb"){|f|f.write pic}
		rescue
		end
		redirect_to arc
	end
	def update_article
		return unless need_login
		raise404 unless /\A\h{40}\z/.match params[:hash]
		arc = Article.find_by(arc_hash:params[:article][:arc_hash].downcase)
		arc.update params.require(:article).permit(:arc_title,:arc_preauthor,:arc_author,:arc_number,:arc_type,
			:arc_beforecontent,:arc_attrbeforecontent,:arc_content,:arc_attraftercontent,:arc_aftercontent,:prdhash)
		redirect_to arc
	end
	private
		def article_url(arc)
			return "/article/"+arc.arc_hash
		end
		def string_firewall(src)
			src.gsub!("\u3000",'  ')
			src.gsub!("\u2022","\u00B7")
			src.gsub!("\t",'    ')
			src.gsub!("\r","\n")
			src.gsub!(/\A\s*/,'')
			src.gsub!(/\s*\Z/,'')
			src.gsub!(/ *\n+ */,"\r\n")
			src.gsub!('<','&lt;')
			src.gsub!('>','&gt;')
			return src
		end
end
