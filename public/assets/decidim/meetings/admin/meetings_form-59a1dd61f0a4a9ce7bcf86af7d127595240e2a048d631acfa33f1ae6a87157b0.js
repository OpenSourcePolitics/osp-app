"use strict";

(function (exports) {
  var _exports$DecidimAdmin = exports.DecidimAdmin;
  var AutoLabelByPositionComponent = _exports$DecidimAdmin.AutoLabelByPositionComponent;
  var AutoButtonsByPositionComponent = _exports$DecidimAdmin.AutoButtonsByPositionComponent;
  var createDynamicFields = _exports$DecidimAdmin.createDynamicFields;
  var createSortList = _exports$DecidimAdmin.createSortList;

  var wrapperSelector = ".meeting-services";
  var fieldSelector = ".meeting-service";

  var autoLabelByPosition = new AutoLabelByPositionComponent({
    listSelector: ".meeting-service:not(.hidden)",
    labelSelector: ".card-title span:first",
    onPositionComputed: function onPositionComputed(el, idx) {
      $(el).find("input[name$=\\[position\\]]").val(idx);
    }
  });

  var autoButtonsByPosition = new AutoButtonsByPositionComponent({
    listSelector: ".meeting-service:not(.hidden)",
    hideOnFirstSelector: ".move-up-service",
    hideOnLastSelector: ".move-down-service"
  });

  var createSortableList = function createSortableList() {
    createSortList(".meeting-services-list:not(.published)", {
      handle: ".service-divider",
      placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
      forcePlaceholderSize: true,
      onSortUpdate: function onSortUpdate() {
        autoLabelByPosition.run();
      }
    });
  };

  var hideDeletedService = function hideDeletedService($target) {
    var inputDeleted = $target.find("input[name$=\\[deleted\\]]").val();

    if (inputDeleted === "true") {
      $target.addClass("hidden");
      $target.hide();
    }
  };

  createDynamicFields({
    placeholderId: "meeting-service-id",
    wrapperSelector: wrapperSelector,
    containerSelector: ".meeting-services-list",
    fieldSelector: fieldSelector,
    addFieldButtonSelector: ".add-service",
    removeFieldButtonSelector: ".remove-service",
    moveUpFieldButtonSelector: ".move-up-service",
    moveDownFieldButtonSelector: ".move-down-service",
    onAddField: function onAddField() {
      createSortableList();

      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onRemoveField: function onRemoveField() {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onMoveUpField: function onMoveUpField() {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onMoveDownField: function onMoveDownField() {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    }
  });

  createSortableList();

  $(fieldSelector).each(function (idx, el) {
    var $target = $(el);

    hideDeletedService($target);
  });

  autoLabelByPosition.run();
  autoButtonsByPosition.run();
})(window);
