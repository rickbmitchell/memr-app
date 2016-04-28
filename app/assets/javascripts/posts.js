$(document).ready(function() {
  var review_text = $("#top_text");
  var counter     = $("#counter1");
  var max_length  = counter.data("maximum-length");

  review_text.keyup(function() {
      counter.text(max_length - $(this).val().length);
  });

  var review_text2 = $("#bottom_text");
  var counter2     = $("#counter2");
  var max_length2  = counter2.data("maximum-length");

  review_text2.keyup(function() {
      counter2.text(max_length2 - $(this).val().length);
  });


});

