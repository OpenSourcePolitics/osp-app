"use strict";

$(function () {
  var $wrapper = $(".slug");
  var $input = $wrapper.find("input");
  var $target = $wrapper.find("span.slug-url-value");

  $input.on("keyup", function (event) {
    $target.html(event.target.value);
  });
});
