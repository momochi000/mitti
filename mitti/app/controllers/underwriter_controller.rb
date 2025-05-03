class UnderwriterController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_underwriter

  def dashboard
  end

  def authorize_underwriter
    authorize! :manage, 'Underwriter'
  end
end
