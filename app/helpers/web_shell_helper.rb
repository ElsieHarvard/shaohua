module WebShellHelper
	def mkcover(arc)
		return render template: "web_shell/mkcover",:locals => {:arc=>arc}
	end
	def web_local_head_img_src(src)
		content_for(:web_local_head_img_src){src}
	end
	def toparticle(sz)
		Article.
		return 
	end
end
