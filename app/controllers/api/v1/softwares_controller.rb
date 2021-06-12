module Api
  module V1
    class SoftwaresController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      before_action :authenticate
      before_action :set_software, only: [:show]

      def index
        softwares = Software.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded sofwares', data: softwares }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the software', data: @software }
      end

      private
      def authenticate
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
          auth_user != nil ? true : false
        end
      end
      def set_software
        @software = Software.find(params[:id])
      end
    end
  end
end
