module ApplicationHelper
  def render_helpscout_beacon(side)
    return unless helpscout_beacon_id(side).present?

    render_beacon(side, :main) unless helpscout_beacon_id(side, :fallback).present?

    render_beacon(side, :main) if default_locale?
    render_beacon(side, :fallback)
  end

  private

  def helpscout_beacon_id(side, type = :main)
    Rails.application.secrets.dig(:helpscout, side, type)
  end

  def render_beacon(side, type)
    render partial: "support/beacon", locals: {
        beacon_id: helpscout_beacon_id(side, type)
    }
  end

  def default_locale?
    current_locale.to_sym == I18n.default_locale
  end
end
