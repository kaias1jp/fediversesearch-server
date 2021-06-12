module Api
  module V1
    class AllSitesController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      before_action :authenticate
      before_action :set_all_site, only:[:index]

      def index
        render json: { status: 'SUCCESS', message: 'Loaded sites', data: @site }
      end
      def authenticate
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
          auth_user != nil ? true : false
        end
      end
      def set_all_site
        @site = Site.all
      end
    end
  end
end
