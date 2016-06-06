$( document ).ready(function() {
  console.log( "ready!" );

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
