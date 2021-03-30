require 'faraday'
module Api
  module V1
    class OptoutController < ApplicationController
      def index
        str = params[:uri]
        if (str == "" || str == nil) then
          render json: { status: 'ERROR', data: "" }
          return
        end

        txt = Resolv::DNS.new().getresources(str, Resolv::DNS::Resource::IN::TXT)
        if (txt[0] == nil) then
          render json: { status: 'ERROR', data: "" }
          return
        end

        txt[0].strings.each {|var|
          if (var == "nofediversesearch") then
            site = Site.find_by(uri: str)
            if (site == nil) then
              render json: { status: 'ERROR', data:"" }
            else
              site.last_confirmation_date = Date.today
              site.optout = true
              site.save
              render json: { status: "SUCCESS", data: "" }
              return
            end
          end
        }
        render json: { status: 'ERROR', data: "" }
      end
    end
  end
end

