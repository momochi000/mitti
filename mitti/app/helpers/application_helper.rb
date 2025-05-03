module ApplicationHelper
  def home_path
    case current_user
    when Users::Admin
      admin_dashboard_path
    when Users::AppliedScientist
      applied_science_dashboard_path
    when Users::Underwriter
      underwriter_dashboard_path
    else
      root_path
    end
  end
  def home_link
    link_to 'Return to dashboard', home_path
  end
end
