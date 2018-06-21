"use strict";

$(function () {
  window.DecidimProposals = window.DecidimProposals || {};

  window.DecidimProposals.bindProposalAddress = function () {
    var $checkbox = $("#proposal_has_address");
    var $addressInput = $("#address_input");

    if ($checkbox.length > 0) {
      var toggleInput = function toggleInput() {
        if ($checkbox[0].checked) {
          $addressInput.show();
        } else {
          $addressInput.hide();
        }
      };
      toggleInput();
      $checkbox.on("change", toggleInput);
    }
  };

  window.DecidimProposals.bindProposalAddress();
});
