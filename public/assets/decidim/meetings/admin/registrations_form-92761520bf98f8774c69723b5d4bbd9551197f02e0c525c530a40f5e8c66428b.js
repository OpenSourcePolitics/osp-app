"use strict";

$(function () {
  var $form = $(".edit_meeting_registrations");

  if ($form.length > 0) {
    (function () {
      var $registrationsEnabled = $form.find("#meeting_registrations_enabled");
      var $availableSlots = $form.find("#meeting_available_slots");
      var $reservedSlots = $form.find("#meeting_reserved_slots");

      var toggleDisabledFields = function toggleDisabledFields() {
        var enabled = $registrationsEnabled.prop("checked");
        $availableSlots.attr("disabled", !enabled);
        $reservedSlots.attr("disabled", !enabled);

        $form.find(".editor-container").each(function (idx, node) {
          var quill = Quill.find(node);
          quill.enable(enabled);
        });
      };

      $registrationsEnabled.on("change", toggleDisabledFields);
      toggleDisabledFields();
    })();
  }
});
