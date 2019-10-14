# frozen_string_literal: true

module CreateInitiativeHelperExtend
  def signature_type_options(initiative_form)
    return all_signature_type_options unless initiative_form.signature_type_updatable?
    return online_signature_type_options unless Decidim::Initiatives.respond_to?(:face_to_face_voting_allowed) && Decidim::Initiatives.face_to_face_voting_allowed
    return offline_signature_type_options unless online_signature_allowed?(initiative_form)

    all_signature_type_options
  end
end

Decidim::Initiatives::CreateInitiativeHelper.send(:include, CreateInitiativeHelperExtend)
