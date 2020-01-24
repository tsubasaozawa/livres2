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

$( document ).on('turbolinks:load', function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
  $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
  }
  $("#user_img").change(function(){
      readURL(this);
  });
});