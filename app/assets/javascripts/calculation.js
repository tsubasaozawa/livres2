$(document).on('turbolinks:load', function() {
  $(function(){
    $('#price_calc').on('input', function(){
      var data = $('#price_calc').val();
      var profit = Math.round(data * 0.9)
      var fee =(data - profit)
      $('.calculation__right').html(fee)
      $('.calculation__right').prepend('¥')
      $('.result__right').html(profit)
      $('.result__right').prepend('¥')
    })
  })
});