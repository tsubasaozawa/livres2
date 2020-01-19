$( document ).on('turbolinks:load', function() {
  $(function(){
    $('.image-subtop').click(function(){
      var class_name = $(this).attr("class");
      var num = class_name.slice(21);
      $('.image-top').hide();
      $('.imagemain' + num).fadeIn();
    });
  });
});