"use strict";

$(function () {
  var $wrapper = $("#notifications");
  var $section = $wrapper.find("section#notifications-list");
  var $noNotificationsText = $wrapper.find(".empty-notifications");
  var $pagination = $wrapper.find("ul.pagination");
  var FADEOUT_TIME = 500;

  var anyNotifications = function anyNotifications() {
    return $wrapper.find(".card--list__item").length > 0;
  };
  var emptyNotifications = function emptyNotifications() {
    if (!anyNotifications()) {
      $section.remove();
      $noNotificationsText.removeClass("hide");
    }
  };

  $section.on("click", ".mark-as-read-button", function (event) {
    var $item = $(event.target).parents(".card--list__item");
    $item.fadeOut(FADEOUT_TIME, function () {
      $item.remove();
      emptyNotifications();
    });
  });

  $wrapper.on("click", ".mark-all-as-read-button", function () {
    $section.fadeOut(FADEOUT_TIME, function () {
      $pagination.remove();
      $wrapper.find(".card--list__item").remove();
      emptyNotifications();
    });
  });

  emptyNotifications();
});
