$(document).on('turbolinks:load', function() {
  $(function(){
    function appendOption(category){
      var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
      return html;
      }

    function appendChildrenBox(insertHTML){
      var childSelecthtml = '';
      childSelectHtml = `<div class='listing-select-wrapper__added select-wrap' id= 'children_wrapper'>
                          <select class="listing-select-wrapper__box--select select-default" id="child_category" name="product[categories][]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                        </div>`;
      $('.listing-product-detail__category').append(childSelectHtml);
    }

    function appendGrandchildrenBox(insertHTML){
      var grandchildSelectHtml = `<div class='listing-select-wrapper__added select-wrap' id= 'grandchildren_wrapper'>
                                    <select class="listing-select-wrapper__box--select select-default" id="grandchild_category" name="product[categories][]">
                                      <option value="---" data-category="---">---</option>
                                      ${insertHTML}
                                    <select>
                                  </div>`;
      $('.listing-product-detail__category').append(grandchildSelectHtml);
    }

    $('#parent_category').on('change',function(){
      var parentCategory = document.getElementById('parent_category').value;
      if (parentCategory != "---"){
        $.ajax({
          url: 'get_category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー 取得に失敗しました')
        })
      }else{
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
      }
    });

    $('.listing-product-detail__category').on('change', '#child_category',function(){
      var childId = $('#child_category option:selected').data('category');
      if (childId != "---"){
        $.ajax({
          url: 'get_category_grandchildren',
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length !=0) {
            $('#grandchildren_wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー 取得に失敗しました')
        })
      }else{
        $('#grandchildren_wrapper').remove();
      }
    });
  });
});
