module Api
  module V1
    class DnscheckController < ApplicationController
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
            render json: { status: 'SUCCESS', data: "" }
            return
          end
        }
        render json: { status: 'ERROR', data: "" }
      end
    end
  end
end

