"use strict";

$(function () {
  (function (exports) {
    var $assemblyScopeEnabled = $("#assembly_scopes_enabled");
    var $assemblyScopeId = $("#assembly_scope_id");

    if ($(".edit_assembly, .new_assembly").length > 0) {
      $assemblyScopeEnabled.on("change", function (event) {
        var checked = event.target.checked;
        exports.theDataPicker.enabled($assemblyScopeId, checked);
      });
      exports.theDataPicker.enabled($assemblyScopeId, $assemblyScopeEnabled.prop("checked"));
    }

    var $form = $(".assembly_form_admin");

    if ($form.length > 0) {
      (function () {

        var $privateSpace = $form.find("#private_space");
        var $isTransparent = $form.find("#is_transparent");
        var $specialFeatures = $form.find("#special_features");

        var toggleDisabledHiddenFields = function toggleDisabledHiddenFields() {
          var enabledPrivateSpace = $privateSpace.find("input[type='checkbox']").prop("checked");
          $isTransparent.find("input[type='checkbox']").attr("disabled", "disabled");
          $specialFeatures.hide();

          if (enabledPrivateSpace) {
            $isTransparent.find("input[type='checkbox']").attr("disabled", !enabledPrivateSpace);
            $specialFeatures.show();
          }
        };

        $privateSpace.on("change", toggleDisabledHiddenFields);
        toggleDisabledHiddenFields();

        var $assemblyType = $form.find("#assembly_assembly_type");
        var $assemblyTypeOther = $form.find("#assembly_type_other");

        var $assemblyCreatedBy = $form.find("#assembly_created_by");
        var $assemblyCreatedByOther = $form.find("#created_by_other");

        var toggleDependsOnSelect = function toggleDependsOnSelect($target, $showDiv) {
          var value = $target.val();
          $showDiv.hide();
          if (value === "others") {
            $showDiv.show();
          }
        };

        $assemblyType.on("change", function (ev) {
          var $target = $(ev.target);
          toggleDependsOnSelect($target, $assemblyTypeOther);
        });

        $assemblyCreatedBy.on("change", function (ev) {
          var $target = $(ev.target);
          toggleDependsOnSelect($target, $assemblyCreatedByOther);
        });

        toggleDependsOnSelect($assemblyType, $assemblyTypeOther);
        toggleDependsOnSelect($assemblyCreatedBy, $assemblyCreatedByOther);
      })();
    }
  })(window);
});
