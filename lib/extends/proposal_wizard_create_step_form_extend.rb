# frozen_string_literal: true

require "active_support/concern"

Decidim::Proposals::ProposalWizardCreateStepForm.class_eval do
  _validators.each do|key, value|
    if [:title, :body].include?(key) && value.kind_of?(Array)
      value.reject! { |v| v.is_a?(EtiquetteValidator) || v.is_a?(ActiveModel::Validations::LengthValidator)  }
    end
  end

  _validate_callbacks.each do |callback|
    if callback.raw_filter.is_a?(EtiquetteValidator) || callback.raw_filter.is_a?(ActiveModel::Validations::LengthValidator)
      if [[:title],[:body],[:title,:body]].include?(callback.raw_filter.attributes)
        _validate_callbacks.delete(callback)
      end
    end
  end
end
