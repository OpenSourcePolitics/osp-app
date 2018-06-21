"use strict";

$(function () {
  var checkProgressPosition = function checkProgressPosition() {
    var progressFix = document.querySelector("[data-progressbox-fixed]"),
        progressRef = document.querySelector("[data-progress-reference]"),
        progressVisibleClass = "is-progressbox-visible";

    if (!progressRef) {
      return;
    }

    var progressPosition = progressRef.getBoundingClientRect().bottom;
    if (progressPosition > 0) {
      progressFix.classList.remove(progressVisibleClass);
    } else {
      progressFix.classList.add(progressVisibleClass);
    }
  };

  window.addEventListener("scroll", checkProgressPosition);

  window.DecidimBudgets = window.DecidimBudgets || {};
  window.DecidimBudgets.checkProgressPosition = checkProgressPosition;
});
"use strict";

$(function () {
  var $projects = $("#projects, #project");
  var $budgetSummaryTotal = $(".budget-summary__total");
  var $budgetExceedModal = $("#limit-excess");

  var totalBudget = parseInt($budgetSummaryTotal.attr("data-total-budget"), 10);
  var totalProjects = parseInt($budgetSummaryTotal.attr("data-total-projects"), 10);

  var cancelEvent = function cancelEvent(event) {
    event.stopPropagation();
    event.preventDefault();
  };

  $projects.on("click", ".budget--list__action", function (event) {
    var currentBudget = parseInt($(".budget-summary__progressbox").attr("data-current-budget"), 10);
    var currentProjects = parseInt($(".budget-summary__progressbox").attr("data-current-projects"), 10);
    var perProject = $budgetSummaryTotal.attr("data_per_project");
    var $currentTarget = $(event.currentTarget);
    var projectBudget = parseInt($currentTarget.attr("data-budget"), 10);
    if ($currentTarget.attr("data-add") && currentProjects == totalProjects && perProject) {
      $budgetExceedModal.foundation("toggle");
      cancelEvent(event);
    } else if ($currentTarget.attr("disabled")) {
      cancelEvent(event);
    } else if ($currentTarget.attr("data-add") && currentBudget + projectBudget > totalBudget && perProject == "false") {
      $budgetExceedModal.foundation("toggle");
      cancelEvent(event);
    }
  });
});
