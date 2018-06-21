/* eslint-disable no-div-regex, no-useless-escape, no-param-reassign, id-length */

/**
 * A plain Javascript component that handles the form filter.
 * @class
 * @augments Component
 */

"use strict";

var _slicedToArray = (function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; })();

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function (exports) {
  var FormFilterComponent = (function () {
    function FormFilterComponent($form) {
      _classCallCheck(this, FormFilterComponent);

      this.$form = $form;
      this.id = this.$form.attr("id") || this._getUID();
      this.mounted = false;

      this._onFormChange = this._onFormChange.bind(this);
      this._onPopState = this._onPopState.bind(this);

      if (window.Decidim.PopStateHandler) {
        this.popStateSubmiter = false;
      } else {
        this.popStateSubmiter = true;
        window.Decidim.PopStateHandler = this.id;
      }
    }

    /**
     * Handles the logic for unmounting the component
     * @public
     * @returns {Void} - Returns nothing
     */

    _createClass(FormFilterComponent, [{
      key: "unmountComponent",
      value: function unmountComponent() {
        if (this.mounted) {
          this.mounted = false;
          this.$form.off("change", "input, select", this._onFormChange);

          exports.Decidim.History.unregisterCallback("filters-" + this.id);
        }
      }

      /**
       * Handles the logic for mounting the component
       * @public
       * @returns {Void} - Returns nothing
       */
    }, {
      key: "mountComponent",
      value: function mountComponent() {
        var _this = this;

        if (this.$form.length > 0 && !this.mounted) {
          this.mounted = true;
          this.$form.on("change", "input, select", this._onFormChange);

          exports.Decidim.History.registerCallback("filters-" + this.id, function (state) {
            _this._onPopState(state);
          });
        }
      }

      /**
       * Finds the current location.
       * @private
       * @returns {String} - Returns the current location.
       */
    }, {
      key: "_getLocation",
      value: function _getLocation() {
        return exports.location.toString();
      }

      /**
       * Finds the values of the location params that match the given regexp.
       * @private
       * @param {Regexp} regex - a Regexp to match the params.
       * @returns {String[]} - An array of values of the params that match the regexp.
       */
    }, {
      key: "_getLocationParams",
      value: function _getLocationParams(regex) {
        var location = decodeURIComponent(this._getLocation());
        var values = location.match(regex);
        if (values) {
          values = values.map(function (val) {
            return val.match(/=(.*)/)[1];
          });
        }
        return values;
      }

      /**
       * Parse current location and get filter values.
       * @private
       * @returns {Object} - An object where a key correspond to a filter field
       *                     and the value is the current value for the filter.
       */
    }, {
      key: "_parseLocationFilterValues",
      value: function _parseLocationFilterValues() {
        // Every location param is constructed like this: filter[key]=value
        var regexpResult = decodeURIComponent(this._getLocation()).match(/filter\[([^\]]*)\](?:\[\])?=([^&]*)/g);

        // The RegExp g flag returns null or an array of coincidences. It doesn't return the match groups
        if (regexpResult) {
          var filterParams = regexpResult.reduce(function (acc, result) {
            var _result$match = result.match(/filter\[([^\]]*)\](\[\])?=([^&]*)/);

            var _result$match2 = _slicedToArray(_result$match, 4);

            var key = _result$match2[1];
            var array = _result$match2[2];
            var value = _result$match2[3];

            if (array) {
              if (!acc[key]) {
                acc[key] = [];
              }
              acc[key].push(value);
            } else {
              acc[key] = value;
            }
            return acc;
          }, {});

          return filterParams;
        }

        return null;
      }

      /**
       * Parse current location and get the current order.
       * @private
       * @returns {string} - The current order
       */
    }, {
      key: "_parseLocationOrderValue",
      value: function _parseLocationOrderValue() {
        var url = this._getLocation();
        var match = url.match(/order=([^&]*)/);
        var $orderMenu = this.$form.find(".order-by .menu");
        var order = $orderMenu.find(".menu a:first").data("order");

        if (match) {
          order = match[1];
        }

        return order;
      }

      /**
       * Clears the form to start with a clean state.
       * @private
       * @returns {Void} - Returns nothing.
       */
    }, {
      key: "_clearForm",
      value: function _clearForm() {
        this.$form.find("input[type=checkbox]").attr("checked", false);
        this.$form.find("input[type=radio]").attr("checked", false);
        this.$form.find(".data-picker").each(function (_index, picker) {
          exports.theDataPicker.clear(picker);
        });

        // This ensure the form is reset in a valid state where a fieldset of
        // radio buttons has the first selected.
        this.$form.find("fieldset input[type=radio]:first").each(function () {
          // I need the this to iterate a jQuery collection
          $(this)[0].checked = true; // eslint-disable-line no-invalid-this
        });
      }

      /**
       * Handles the logic when going back to a previous state in the filter form.
       * @private
       * @param {Object} state - state stored along with location URL
       * @returns {Void} - Returns nothing.
       */
    }, {
      key: "_onPopState",
      value: function _onPopState(state) {
        var _this2 = this;

        this._clearForm();

        var filterParams = this._parseLocationFilterValues();
        var currentOrder = this._parseLocationOrderValue();

        this.$form.find("input.order_filter").val(currentOrder);

        if (filterParams) {
          var fieldIds = Object.keys(filterParams);

          // Iterate the filter params and set the correct form values
          fieldIds.forEach(function (fieldId) {
            var field = null;

            // Since we are using Ruby on Rails generated forms the field ids for a
            // checkbox or a radio button has the following form: filter_${key}_${value}
            field = _this2.$form.find("input#filter_" + fieldId + "_" + filterParams[fieldId]);

            if (field.length > 0) {
              field[0].checked = true;
            } else {
              // If the field is not a checkbox neither a radio it means is a input or a select.
              // Ruby on Rails ensure the ids are constructed like this: filter_${key}
              field = _this2.$form.find("input#filter_" + fieldId + ",select#filter_" + fieldId);

              if (field.length > 0) {
                field.val(filterParams[fieldId]);
              }
            }
          });
        }

        // Retrieves picker information for selected values (value, text and link) from the state object
        $(".data-picker", this.$form).each(function (_index, picker) {
          var pickerState = state[picker.id];
          if (pickerState) {
            exports.theDataPicker.load(picker, pickerState);
          }
        });

        // Only one instance should submit the form on browser history navigation
        if (this.popStateSubmiter) {
          exports.Rails.fire(this.$form[0], "submit");
        }
      }

      /**
       * Handles the logic to update the current location after a form change event.
       * @private
       * @returns {Void} - Returns nothing.
       */
    }, {
      key: "_onFormChange",
      value: function _onFormChange() {
        var formAction = this.$form.attr("action");
        var params = this.$form.serialize();

        var newUrl = "";
        var newState = {};

        exports.Rails.fire(this.$form[0], "submit");

        if (formAction.indexOf("?") < 0) {
          newUrl = formAction + "?" + params;
        } else {
          newUrl = formAction + "&" + params;
        }

        // Stores picker information for selected values (value, text and link) in the state object
        $(".data-picker", this.$form).each(function (_index, picker) {
          newState[picker.id] = exports.theDataPicker.save(picker);
        });

        exports.Decidim.History.pushState(newUrl, newState);
      }

      /**
       * Generates a unique identifier for the form.
       * @private
       * @returns {String} - Returns a unique identifier
       */
    }, {
      key: "_getUID",
      value: function _getUID() {
        return "filter-form-" + new Date().setUTCMilliseconds() + "-" + Math.floor(Math.random() * 10000000);
      }
    }]);

    return FormFilterComponent;
  })();

  exports.Decidim = exports.Decidim || {};
  exports.Decidim.FormFilterComponent = FormFilterComponent;
})(window);
/* eslint-disable no-invalid-this */

// Initializes the form filter.
"use strict";

(function (exports) {
  var FormFilterComponent = exports.Decidim.FormFilterComponent;

  $(function () {
    $("form.new_filter").each(function () {
      var formFilter = new FormFilterComponent($(this));

      formFilter.mountComponent();
    });
  });
})(window);
