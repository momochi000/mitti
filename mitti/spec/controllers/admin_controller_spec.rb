# Disabling this spec for now, there seems to be issues with testing devise in the latest version of rails: https://github.com/heartcombo/devise/issues/5771
#require 'rails_helper'
#RSpec.describe AdminController, type: :controller do
#  let(:password) { '123456' }
#  let(:admin) { FactoryBot.create(:admin, password:) }
#
#  context 'sign in' do
#    it 'allows admin to sign in' do
#      sign_in admin, scope: :admins
#
#      get :dashboard
#
#      expect(response).to have_http_status(:success)
#      expect(response.body).to include("Admin Dashboard")
#    end
#  end
#end

#require 'rails_helper'
#
#
#RSpec.describe AdminController, type: :controller do
#  include Devise::Test::ControllerHelpers
#
#  before do
#    @request.env["devise.mapping"] = Devise.mappings[:user]
#  end
#
#  context 'sign in' do
#    let(:password) { '123456' }
#    let(:admin) { FactoryBot.create(:admin, password:) }
#
#    it 'allows admin to sign in' do
#      sign_in admin
#
#      get :dashboard
#
#      expect(response).to have_http_status(:success)
#      expect(response.body).to include("Admin Dashboard")
#    end
#  end
#end
