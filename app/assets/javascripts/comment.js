function Recipe(id, name, description, comments) {
  this.name = name;
  this.description = description;
  this.comments = comments;

  this.displayInfo = function() {
    var commentLength = this.comments.length;
    return this.comments.length;
  }
}

function getRecipeInfo(id) {
    $.get( "recipes/"+id+".json", function( data ) {
      var this_recipe = new Recipe(id, data.name, data.description, data.comments)
      var commentLength = this_recipe.displayInfo();
      $(".commentsNum_"+id).text(commentLength + ' comment');
    });
    return false;
}


$( document ).ready(function() {
  console.log( "ready!" );
  $(".recipe-card").on('click',function(ev) {
    var id = $(this).attr('data-id');
    getRecipeInfo(id);
    $('#recipe-info-'+id).slideToggle('fast');
    ev.stopPropagation();
});
  $('#comment_form').submit(function() {
    var valuesToSubmit = $(this).serialize();
    $.ajax({
      type: "POST",
      url: $(this).attr('action'), //sumbits it to the given url of the form
      data: valuesToSubmit,
      dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json){
      console.log("success", json);
      $('#comment').append('<blockquote>'+json.comment_text + ' <p class="comment_by"> by ' + json.user_email+'</p></blockquote>' );
      $('#comment_comment_text').val(null);
    });
    return false; // prevents normal behaviour
  });

});
