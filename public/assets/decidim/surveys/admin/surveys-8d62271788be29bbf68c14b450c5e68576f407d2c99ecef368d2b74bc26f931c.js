"use strict";

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function (exports) {
  var AutoButtonsByMinItemsComponent = (function () {
    function AutoButtonsByMinItemsComponent() {
      var options = arguments.length <= 0 || arguments[0] === undefined ? {} : arguments[0];

      _classCallCheck(this, AutoButtonsByMinItemsComponent);

      this.listSelector = options.listSelector;
      this.minItems = options.minItems;
      this.hideOnMinItemsOrLessSelector = options.hideOnMinItemsOrLessSelector;

      this.run();
    }

    _createClass(AutoButtonsByMinItemsComponent, [{
      key: "run",
      value: function run() {
        var $list = $(this.listSelector);
        var $items = $list.find(this.hideOnMinItemsOrLessSelector);

        if ($list.length <= this.minItems) {
          $items.hide();
        } else {
          $items.show();
        }
      }
    }]);

    return AutoButtonsByMinItemsComponent;
  })();

  exports.DecidimAdmin = exports.DecidimAdmin || {};
  exports.DecidimAdmin.AutoButtonsByMinItemsComponent = AutoButtonsByMinItemsComponent;
})(window);
"use strict";

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function (exports) {
  var AutoSelectOptionsByTotalItemsComponent = (function () {
    function AutoSelectOptionsByTotalItemsComponent() {
      var options = arguments.length <= 0 || arguments[0] === undefined ? {} : arguments[0];

      _classCallCheck(this, AutoSelectOptionsByTotalItemsComponent);

      this.wrapperSelector = options.wrapperSelector;
      this.selectSelector = options.selectSelector;
      this.listSelector = options.listSelector;
    }

    _createClass(AutoSelectOptionsByTotalItemsComponent, [{
      key: "run",
      value: function run() {
        var $list = $(this.listSelector);
        var $selectField = $list.parents(this.wrapperSelector).find(this.selectSelector);

        $selectField.find("option").slice(1).remove();

        for (var idx = 2; idx <= $list.length; idx += 1) {
          $("<option value=\"" + idx + "\">" + idx + "</option>").appendTo($selectField);
        }
      }
    }]);

    return AutoSelectOptionsByTotalItemsComponent;
  })();

  exports.DecidimAdmin = exports.DecidimAdmin || {};
  exports.DecidimAdmin.AutoSelectOptionsByTotalItemsComponent = AutoSelectOptionsByTotalItemsComponent;
})(window);
"use strict";

(function (exports) {
  var _exports$DecidimAdmin = exports.DecidimAdmin;
  var AutoLabelByPositionComponent = _exports$DecidimAdmin.AutoLabelByPositionComponent;
  var AutoButtonsByPositionComponent = _exports$DecidimAdmin.AutoButtonsByPositionComponent;
  var AutoButtonsByMinItemsComponent = _exports$DecidimAdmin.AutoButtonsByMinItemsComponent;
  var AutoSelectOptionsByTotalItemsComponent = _exports$DecidimAdmin.AutoSelectOptionsByTotalItemsComponent;
  var createFieldDependentInputs = _exports$DecidimAdmin.createFieldDependentInputs;
  var createDynamicFields = _exports$DecidimAdmin.createDynamicFields;
  var createSortList = _exports$DecidimAdmin.createSortList;
  var createQuillEditor = exports.Decidim.createQuillEditor;

  var wrapperSelector = ".survey-questions";
  var fieldSelector = ".survey-question";
  var questionTypeSelector = "select[name$=\\[question_type\\]]";
  var answerOptionFieldSelector = ".survey-question-answer-option";
  var answerOptionsWrapperSelector = ".survey-question-answer-options";
  var answerOptionRemoveFieldButtonSelector = ".remove-answer-option";
  var maxChoicesWrapperSelector = ".survey-question-max-choices";

  var autoLabelByPosition = new AutoLabelByPositionComponent({
    listSelector: ".survey-question:not(.hidden)",
    labelSelector: ".card-title span:first",
    onPositionComputed: function onPositionComputed(el, idx) {
      $(el).find("input[name$=\\[position\\]]").val(idx);
    }
  });

  var autoButtonsByPosition = new AutoButtonsByPositionComponent({
    listSelector: ".survey-question:not(.hidden)",
    hideOnFirstSelector: ".move-up-question",
    hideOnLastSelector: ".move-down-question"
  });

  var createAutoMaxChoicesByNumberOfAnswerOptions = function createAutoMaxChoicesByNumberOfAnswerOptions(fieldId) {
    return new AutoSelectOptionsByTotalItemsComponent({
      wrapperSelector: fieldSelector,
      selectSelector: maxChoicesWrapperSelector + " select",
      listSelector: "#" + fieldId + " " + answerOptionsWrapperSelector + " .survey-question-answer-option:not(.hidden)"
    });
  };

  var createAutoButtonsByMinItemsForAnswerOptions = function createAutoButtonsByMinItemsForAnswerOptions(fieldId) {
    return new AutoButtonsByMinItemsComponent({
      wrapperSelector: fieldSelector,
      listSelector: "#" + fieldId + " " + answerOptionsWrapperSelector + " .survey-question-answer-option:not(.hidden)",
      minItems: 2,
      hideOnMinItemsOrLessSelector: answerOptionRemoveFieldButtonSelector
    });
  };

  var createSortableList = function createSortableList() {
    createSortList(".survey-questions-list:not(.published)", {
      handle: ".question-divider",
      placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
      forcePlaceholderSize: true,
      onSortUpdate: function onSortUpdate() {
        autoLabelByPosition.run();
      }
    });
  };

  var createDynamicFieldsForAnswerOptions = function createDynamicFieldsForAnswerOptions(fieldId) {
    var autoButtons = createAutoButtonsByMinItemsForAnswerOptions(fieldId);
    var autoSelectOptions = createAutoMaxChoicesByNumberOfAnswerOptions(fieldId);

    return createDynamicFields({
      placeholderId: "survey-question-answer-option-id",
      wrapperSelector: "#" + fieldId + " " + answerOptionsWrapperSelector,
      containerSelector: ".survey-question-answer-options-list",
      fieldSelector: answerOptionFieldSelector,
      addFieldButtonSelector: ".add-answer-option",
      removeFieldButtonSelector: answerOptionRemoveFieldButtonSelector,
      onAddField: function onAddField() {
        autoButtons.run();
        autoSelectOptions.run();
      },
      onRemoveField: function onRemoveField() {
        autoButtons.run();
        autoSelectOptions.run();
      }
    });
  };

  var dynamicFieldsForAnswerOptions = {};

  var isMultipleChoiceOption = function isMultipleChoiceOption($selectField) {
    var value = $selectField.val();

    return value === "single_option" || value === "multiple_option" || value === "sorting";
  };

  var setupInitialQuestionAttributes = function setupInitialQuestionAttributes($target) {
    var fieldId = $target.attr("id");
    var $fieldQuestionTypeSelect = $target.find(questionTypeSelector);

    createFieldDependentInputs({
      controllerField: $fieldQuestionTypeSelect,
      wrapperSelector: fieldSelector,
      dependentFieldsSelector: answerOptionsWrapperSelector,
      dependentInputSelector: answerOptionFieldSelector + " input",
      enablingCondition: function enablingCondition($field) {
        return isMultipleChoiceOption($field);
      }
    });

    createFieldDependentInputs({
      controllerField: $fieldQuestionTypeSelect,
      wrapperSelector: fieldSelector,
      dependentFieldsSelector: maxChoicesWrapperSelector,
      dependentInputSelector: "select",
      enablingCondition: function enablingCondition($field) {
        return $field.val() === "multiple_option";
      }
    });

    dynamicFieldsForAnswerOptions[fieldId] = createDynamicFieldsForAnswerOptions(fieldId);

    var dynamicFields = dynamicFieldsForAnswerOptions[fieldId];

    var onQuestionTypeChange = function onQuestionTypeChange() {
      if (isMultipleChoiceOption($fieldQuestionTypeSelect)) {
        var nOptions = $fieldQuestionTypeSelect.parents(fieldSelector).find(answerOptionFieldSelector).length;

        if (nOptions === 0) {
          dynamicFields._addField();
          dynamicFields._addField();
        }
      }
    };

    $fieldQuestionTypeSelect.on("change", onQuestionTypeChange);

    onQuestionTypeChange();
  };

  var hideDeletedQuestion = function hideDeletedQuestion($target) {
    var inputDeleted = $target.find("input[name$=\\[deleted\\]]").val();

    if (inputDeleted === "true") {
      $target.addClass("hidden");
      $target.hide();
    }
  };

  createDynamicFields({
    placeholderId: "survey-question-id",
    wrapperSelector: wrapperSelector,
    containerSelector: ".survey-questions-list",
    fieldSelector: fieldSelector,
    addFieldButtonSelector: ".add-question",
    removeFieldButtonSelector: ".remove-question",
    moveUpFieldButtonSelector: ".move-up-question",
    moveDownFieldButtonSelector: ".move-down-question",
    onAddField: function onAddField($field) {
      setupInitialQuestionAttributes($field);
      createSortableList();

      $field.find(".editor-container").each(function (idx, el) {
        createQuillEditor(el);
      });

      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onRemoveField: function onRemoveField($field) {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();

      $field.find(answerOptionRemoveFieldButtonSelector).each(function (idx, el) {
        dynamicFieldsForAnswerOptions[$field.attr("id")]._removeField(el);
      });
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

    hideDeletedQuestion($target);
    setupInitialQuestionAttributes($target);
  });

  autoLabelByPosition.run();
  autoButtonsByPosition.run();
})(window);
