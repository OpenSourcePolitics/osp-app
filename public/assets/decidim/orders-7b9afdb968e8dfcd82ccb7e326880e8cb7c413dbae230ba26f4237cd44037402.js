"use strict";

$(function () {
  var _window$Decidim$History = window.Decidim.History;
  var pushState = _window$Decidim$History.pushState;
  var registerCallback = _window$Decidim$History.registerCallback;

  $(document).on("click", ".order-by a", function (event) {
    var $target = $(event.target);

    $target.parents(".menu").find("a:first").text($target.text());

    pushState($target.attr("href"));
  });

  registerCallback("orders", function () {
    var url = window.location.toString();
    var match = url.match(/order=([^&]*)/);
    var $orderMenu = $(".order-by .menu");
    var order = $orderMenu.find(".menu a:first").data("order");

    if (match) {
      order = match[1];
    }

    var linkText = $orderMenu.find(".menu a[data-order=\"" + order + "\"]").text();

    $orderMenu.find("a:first").text(linkText);
  });
});
