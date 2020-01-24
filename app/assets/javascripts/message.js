$(function() {
  var $textarea = $('#textarea');
  var lineHeight = parseInt($textarea.css('lineHeight'));
  $textarea.on('input', function(e) {
    var lines = ($(this).val() + '\n').match(/\n/g).length;
    $(this).height(lineHeight * lines);
  });
});


$(function(){
  function buildHTML(message){
    var html =`<div class="message-views__detail-view" data-message-id="${message.id}"><div class="message-views__detail-view__message"><div class="message-views__detail-view__message__text"><p>${message.message}</p></div><div class="message-views__detail-view__message__user-date"><div class="message-views__detail-view__message__user-date__user">${message.nickname}</div><div class="message-views__detail-view__message__user-date__date">${message.date}</div><div class="message-views__detail-view__message__user-date__date-time">${message.time}</div></div></div></div>`
    return html;
  }

  $("#new-message").on("submit",function(e){
    e.preventDefault();
    var formData = new FormData(this);
    console.log(formData)
    var url = $(this).attr('action');

    $.ajax({
      url: url,
      type: "post",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      console.log(data)
      var html = buildHTML(data);
      console.log(html)
      $(".message-views").append(html);
      $("form")[0].reset();
      $('.message-views').animate({scrollTop: $('.message-views')[0].scrollHeight}),'fast';
    })
    .fail(function(data){
      alert("エラー");
    })
    .always(function(data){
      $('.chat-box__submit').prop('disabled', false);
    })
  });
});