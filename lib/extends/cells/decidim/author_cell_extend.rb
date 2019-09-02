module AuthorCellExtend
  def badge_icon badge
    if badge == "eid-verified"
      external_icon "icon-eid-verified.svg"
    else
      icon badge
    end
  end
end

Decidim::AuthorCell.class_eval do
  prepend(AuthorCellExtend)
end
