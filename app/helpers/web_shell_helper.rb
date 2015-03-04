module WebShellHelper
	def mkcover(arc)
		return render template: "web_shell/mkcover",:locals => {:arc=>arc}
	end
end
