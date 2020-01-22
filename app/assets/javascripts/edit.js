$(document).on('turbolinks:load', function(){
  var controller = $('body').data("controller");
  var counter = $(".exhibit-wrapper__main__image__cards");
  try {
    if (controller != "items"){throw new Error(e)}
  function buildHTML(img, number){ 
  html = `<div class="exhibit-wrapper__main__image__cards__card">
            <div class="exhibit-wrapper__main__image__cards__card__image">
              <img src= ${img} class: 'exhibit-image'>
            </div>
            <div class="exhibit-wrapper__main__image__cards__card__button">
              <p>編集(仮)</p> 
              <p class="item-image__delete-button__append" data-image=${number}>削除</p>
            </div>
          </div>`;
  return html;
  }
  for (var i=0; i<10; i++) {
    if ($(`.item-edit__image-${i}`).attr("src") != "") {
      var number = counter.attr("data-exhibitid");
      var new_number = Number(number)   + 1;
      counter.attr("data-exhibitid", new_number);
      $(`#item_images_attributes_${i}_image`).prop('readonly', true);
      $(`#item_images_attributes_${i}_image`).next().prop('readonly', false);
      // 新規出品とは違い、formが再利用されないようにアンカーの後ろに移動
      $(".exhibit-wrapper__main__image__cards_anchor").after($(`#item_images_attributes_${i}_image`));
      $(`#item_images_attributes_${i}_image`).after($(`#item_images_attributes_${i}__destroy`));
      // 二段目に移行する処理
      if (counter.attr("data-exhibitid") == 5) {
        $(".exhibit-wrapper__main__image__cards").css("height", "320px");
      }
      var imgUrl = $(`.item-edit__image-${i}`).attr("src");
      addCard = buildHTML(imgUrl, i);
      $(".exhibit-wrapper__main__image__cards").prepend(addCard);
      if (counter.attr("data-exhibitid") == 10) {
        $(".exhibit-wrapper__main__image__drag-wrapper").css("display", "none");
      }
    }
  }
  }catch(e){}
})