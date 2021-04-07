
$(document).on('ready turbolinks:load', () => {
	scrollerSignUp();
})
function scrollerSignUp(){
	$('#productscrolldown').on('click', function(){
		// debugger
		$('#scroller').removeClass('d-none');

	})
}