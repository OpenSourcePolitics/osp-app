"use strict";

$(function () {
  (function (exports) {
    var $processesGrid = $("#processes-grid");
    var $loading = $processesGrid.find(".loading");
    var filterLinksSelector = ".order-by__tabs a";

    $loading.hide();

    $processesGrid.on("click", filterLinksSelector, function (event) {
      var $target = $(event.target);
      var $processesGridCards = $processesGrid.find(".card-grid .column");

      $(filterLinksSelector).removeClass("is-active");
      $target.addClass("is-active");

      $processesGridCards.hide();
      $loading.show();

      if (exports.history) {
        exports.history.pushState(null, null, $target.attr("href"));
      }
    });
  })(window);
});
