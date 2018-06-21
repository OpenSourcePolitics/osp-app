"use strict";

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function (exports) {
  var OptionAttachedInputsComponent = (function () {
    function OptionAttachedInputsComponent() {
      var options = arguments.length <= 0 || arguments[0] === undefined ? {} : arguments[0];

      _classCallCheck(this, OptionAttachedInputsComponent);

      this.wrapperField = options.wrapperField;
      this.controllerFieldSelector = options.controllerFieldSelector;
      this.dependentInputSelector = options.dependentInputSelector;
      this.controllerSelector = this.wrapperField.find(this.controllerFieldSelector);
      this._bindEvent();
      this._run();
    }

    _createClass(OptionAttachedInputsComponent, [{
      key: "_run",
      value: function _run() {
        var _this = this;

        this.controllerSelector.each(function (idx, el) {
          var $field = $(el);
          var enabled = $field.is(":checked");

          $field.parents("label").find(_this.dependentInputSelector).prop("disabled", !enabled);
        });
      }
    }, {
      key: "_bindEvent",
      value: function _bindEvent() {
        var _this2 = this;

        this.controllerSelector.on("change", function () {
          _this2._run();
        });
      }
    }]);

    return OptionAttachedInputsComponent;
  })();

  exports.Decidim = exports.Decidim || {};
  exports.Decidim.createOptionAttachedInputs = function (options) {
    return new OptionAttachedInputsComponent(options);
  };
})(window);
"use strict";

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function (exports) {
  var AutosortableCheckboxesComponent = (function () {
    function AutosortableCheckboxesComponent() {
      var options = arguments.length <= 0 || arguments[0] === undefined ? {} : arguments[0];

      _classCallCheck(this, AutosortableCheckboxesComponent);

      this.wrapperField = options.wrapperField;
      this._bindEvent();
      this._run();
    }

    _createClass(AutosortableCheckboxesComponent, [{
      key: "_run",
      value: function _run() {
        var _this = this;

        $(this.wrapperField).find("input[type=checkbox]").each(function (idx, el) {
          var $parentLabel = $(el).parents("label");

          if ($(el).is(":checked")) {
            var $lastSorted = _this.wrapperField.find("label.sorted").last();

            if ($lastSorted.length > 0) {
              $lastSorted.removeClass("last-sorted");
              $parentLabel.insertAfter($lastSorted);
            } else {
              $parentLabel.insertBefore(_this.wrapperField.find("label:first-child"));
            }

            $parentLabel.addClass("sorted");
            $parentLabel.addClass("last-sorted");
          } else {
            var $lastUnsorted = _this.wrapperField.find("label:not(.sorted)").last();

            if ($lastUnsorted.length > 0) {
              $parentLabel.insertBefore($lastUnsorted);
            } else {
              $parentLabel.insertAfter(_this.wrapperField.find("label:last-child"));
            }

            $parentLabel.removeClass("sorted");
          }
        });

        $(this.wrapperField).find("label").each(function (idx, el) {
          var $positionSelector = $(el).find(".position");
          var $positionField = $(el).find("input[name$=\\[position\\]]");

          if ($(el).hasClass("sorted")) {
            $positionField.val(idx);
            $positionField.prop("disabled", false);
            $positionSelector.html(idx + 1 + ". ");
          } else {
            $positionField.val("");
            $positionField.prop("disabled", true);
            $positionSelector.html("");
          }
        });
      }
    }, {
      key: "_bindEvent",
      value: function _bindEvent() {
        var _this2 = this;

        $(this.wrapperField).find("input[type=checkbox]").on("change", function () {
          _this2._run();
        });
      }
    }]);

    return AutosortableCheckboxesComponent;
  })();

  exports.Decidim = exports.Decidim || {};
  exports.Decidim.createAutosortableCheckboxes = function (options) {
    return new AutosortableCheckboxesComponent(options);
  };
})(window);
"use strict";

(function (exports) {
  var _exports$Decidim = exports.Decidim;
  var createOptionAttachedInputs = _exports$Decidim.createOptionAttachedInputs;
  var createAutosortableCheckboxes = _exports$Decidim.createAutosortableCheckboxes;

  $(".radio-button-collection, .check-box-collection").each(function (idx, el) {
    createOptionAttachedInputs({
      wrapperField: $(el),
      controllerFieldSelector: "input[type=radio], input[type=checkbox]",
      dependentInputSelector: "input[type=text], input[type=hidden]"
    });
  });

  $(".sortable-check-box-collection").each(function (idx, el) {
    createAutosortableCheckboxes({
      wrapperField: $(el)
    });
  });
})(window);
