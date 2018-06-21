"use strict";

window.addEventListener("message", function (event) {
  if (event.data.type === "GET_HEIGHT") {
    var body = document.body;
    var html = document.documentElement;
    var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);

    parent.postMessage({ type: "SET_HEIGHT", height: height }, "*");
  }
});

$(function () {
  // Set target blank for all widget links.
  $("a").attr("target", "_blank");
});
