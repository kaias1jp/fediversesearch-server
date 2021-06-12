module Api
  module V1
    class SitesController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      before_action :authenticate
      before_action :set_site, only:[:update]
      before_action :set_site_from_uri, only:[:index]

      def index
        render json: { status: 'SUCCESS', message: 'Loaded sites', data: @site }
      end
      def create
        site = Site.new(site_params_create)
        if site.save
          render json: { status: 'SUCCESS', data: site }
        else
          render json: { status: 'ERROR', data: site.errors }
        end
      end
      def update
        if @site.update(site_params_update)
          render json: { status: 'SUCCESS', message: 'Updated the site', data: @site }
        else
          render json: { status: 'ERROR', message: 'Not updated', data: @site.errors }
        end
      end
      def authenticate
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
          auth_user != nil ? true : false
        end
      end
      def set_site
        @site = Site.find(params[:id])
      end
      def set_site_from_uri
        @site = Site.find_by(uri: params[:uri])
      end
      def site_params_create
        params.require(:site).permit(:uri, :software_id)
      end
      def site_params_update
        params.require(:site).permit(:uri, :title, :short_description, :description, :registrations,:thumbnail, :last_confirmation_date, :dns_status, :http_status, :software_id, :optout)
      end
    end
  end
end
