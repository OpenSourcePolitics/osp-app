"use strict";

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function (exports) {
  var SubformTogglerComponent = (function () {
    function SubformTogglerComponent() {
      var options = arguments.length <= 0 || arguments[0] === undefined ? {} : arguments[0];

      _classCallCheck(this, SubformTogglerComponent);

      this.controllerSelect = options.controllerSelect;
      this.subformWrapperClass = options.subformWrapperClass;
      this._bindEvent();
      this.run();
    }

    _createClass(SubformTogglerComponent, [{
      key: "run",
      value: function run() {
        var $controllerSelect = this.controllerSelect;
        var subformWrapperClass = this.subformWrapperClass;
        var value = $controllerSelect.val();

        var $form = $controllerSelect.parents("form");
        var $subforms = $form.find("." + subformWrapperClass);
        var $selectedSubform = $subforms.filter("#" + subformWrapperClass + "-" + value);

        $subforms.find("input,textarea").prop("disabled", true);
        $subforms.hide();

        $selectedSubform.find("input,textarea").prop("disabled", false);
        $selectedSubform.show();
      }
    }, {
      key: "_bindEvent",
      value: function _bindEvent() {
        var _this = this;

        this.controllerSelect.on("change", function () {
          _this.run();
        });
      }
    }]);

    return SubformTogglerComponent;
  })();

  exports.DecidimAdmin = exports.DecidimAdmin || {};
  exports.DecidimAdmin.SubformTogglerComponent = SubformTogglerComponent;
})(window);
"use strict";

(function (exports) {
  var SubformTogglerComponent = exports.DecidimAdmin.SubformTogglerComponent;

  var subformToggler = new SubformTogglerComponent({
    controllerSelect: $("select#impersonate_user_authorization_handler_name"),
    subformWrapperClass: "authorization-handler"
  });

  subformToggler.run();
})(window);
