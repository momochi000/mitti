class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    case resource
    when Users::Admin
      admin_dashboard_path
    when Users::AppliedScientist
      applied_science_dashboard_path
    when Users::Underwriter
      underwriter_dashboard_path
    else
      logger.warn "User logging in without a valid type: #{resource}"
      super
    end
  end
end
