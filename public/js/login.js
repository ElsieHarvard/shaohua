function login() {
	$.ajax({
		type:'POST',
		url:'/login/index.rb',
		data:$("#login").serialize+'&do=login',
		success:function(msg){
			alert(msg);
		},
		error:function(msg){
			alert('Failed to login, please check your internet connection.');
		}
	})
	return false;
}
