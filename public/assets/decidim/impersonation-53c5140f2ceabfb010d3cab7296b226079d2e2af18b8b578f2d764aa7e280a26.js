"use strict";

(function (exports) {
  exports.$(function () {
    var $impersonationWarning = $(".impersonation-warning");
    var endsAt = exports.moment($impersonationWarning.data("session-ends-at"));

    setInterval(function () {
      var diff = (endsAt - exports.moment()) / 60000;
      var diffInMinutes = Math.round(diff);
      $impersonationWarning.find(".minutes").html(diffInMinutes);

      if (diff <= 0) {
        window.location.reload();
      }
    }, 1000);
  });
})(window);
