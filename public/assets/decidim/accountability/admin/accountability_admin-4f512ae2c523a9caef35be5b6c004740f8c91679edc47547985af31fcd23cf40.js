"use strict";

$("#result_decidim_accountability_status_id").change(function () {
  /* eslint-disable no-invalid-this */
  var progress = $(this).find(":selected").data("progress");
  if (progress || progress === 0) {
    $("#result_progress").val(progress);
  }
});

$(function () {
  $(document).on("open.zf.reveal", "#data_picker-modal", function () {
    var xhr = null;

    $("#data_picker-autocomplete").autoComplete({
      minChars: 2,
      source: function source(term, response) {
        try {
          xhr.abort();
        } catch (exception) {
          xhr = null;
        }

        var url = $("#proposal-picker-choose").attr("href");
        xhr = $.getJSON(url, { term: term }, function (data) {
          response(data);
        });
      },
      renderItem: function renderItem(item, search) {
        var sanitizedSearch = search.replace(/[-/\\^$*+?.()|[\]{}]/g, "\\$&");
        var re = new RegExp("(" + sanitizedSearch.split(" ").join("|") + ")", "gi");
        var title = item[0];
        var modelId = item[1];
        var val = "#" + modelId + "- " + title;
        return "<div class=\"autocomplete-suggestion\" data-model-id=\"" + modelId + "\" data-val =\"" + title + "\">" + val.replace(re, "<b>$1</b>") + "</div>";
      },
      onSelect: function onSelect(event, term, item) {
        var choose = $("#proposal-picker-choose");
        var modelId = item.data("modelId");
        var val = "#" + modelId + "- " + item.data("val");
        choose.data("picker-value", modelId);
        choose.data("picker-text", val);
        choose.data("picker-choose", "");
      }
    });
  });
});
