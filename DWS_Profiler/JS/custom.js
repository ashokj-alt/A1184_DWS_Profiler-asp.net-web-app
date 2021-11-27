$(document).ready(function () {
  $('.loader-wrap').delay(2000).fadeOut();
  $(".bg-load").delay(200).fadeOut(400);
  $(".back-img").delay(200).fadeOut(500);
  $('.header-wrap').load('/include/header.html');
  $('.footer-wrap').load('/include/footer.html');

  $('.btn-accordion').click(function(){
  	$(this).find('.fa').toggleClass('fa-chevron-circle-up');
  });
});