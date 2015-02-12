jQuery(document).ready(function($){
	// browser window scroll (in pixels) after which the "back to top" link is shown
	var offset = $('.cd-main-header').height(),
		//browser window scroll (in pixels) after which the "back to top" link opacity is reduced
		offset_opacity = $(window).height(),
		//duration of the top scrolling animation (in ms)
		scroll_top_duration = $(window).height();

	//hide or show the "back to top" link
	$(window).scroll(function(){
		( $(this).scrollTop() > offset ) ? $('.cd-back-top').addClass('cd-is-visible') : $('.cd-back-top').removeClass('cd-is-visible cd-fade-out');
		if( $(this).scrollTop() > offset_opacity ) { 
			$('.cd-back-top').addClass('cd-fade-out');
		}
	});

	//smooth scroll to top
	$('.cd-back-top').on('click', function(event){
		event.preventDefault();
		$('body,html').animate({
			scrollTop: 0 ,
		 	}, scroll_top_duration
		);
	});

});
