$(function(){
  // alert('test')
  $("#ingred_btn").click(function(){
    $("#new_ingredient").append(
                                 '<label for="new-ingredient">Ingredient</label>' +
                                   '<input type="text" class="form-control">'
                                 );
  });
});
