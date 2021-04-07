$(document).on(‘ready turbolinks:load’, () => {
	scrollerSignUp();
})
function scrollerSignUp(){
	$('productscrolldown').on('click', function(){
		$('#scroller').removeClass('d-none');
	})
}