$( document ).on('turbolinks:load', function() {
  $(function(){
    $(".delete_btn").on('click', function(){
      var deleteConfirm = confirm('削除してよろしいでしょうか？');

      if(deleteConfirm == true) {
        var clickEle = $(this)
        var productID = $(clickEle).parent().parent().parent().parent().parent().attr("action"); 
        var imageID = clickEle.parent().parent().attr('data-image-id')
  
       
        $.ajax({
          url: productID + "/image_destroy",
          type: 'POST',
          data: {image_id : imageID},
          dataType: 'json'
        })

        .done(function(){
          clickEle.parent().parent().remove();
        })

        .fail(function(){
          alert('削除できませんでした')
        });
      } else {
        (function(e){
          alert('画像が見つかりません')
        });
      };
    });
  });
});


$(function(){
  $(document).on('click', '.change_btn-text', function(){
    var clickEle = $(this)
    var imageID = clickEle.parent().parent().parent().attr('data-image-id')
    $("#edit-file" + imageID).click();
  })
})

