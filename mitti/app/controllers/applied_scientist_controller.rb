class AppliedScientistController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_applied_scientist

  def dashboard
  end

  def authorize_applied_scientist
    authorize! :manage, 'AppliedScientist'
  end
end
