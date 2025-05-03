class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def dashboard
  end

  def authorize_admin
    authorize! :manage, 'Admin'
  end
end
