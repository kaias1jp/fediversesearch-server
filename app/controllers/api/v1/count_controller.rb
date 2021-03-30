module Api
  module V1
    class CountController < ApplicationController
      def index
        count = Site.where.not(last_confirmation_date: nil).where.not(title: [nil, ""]).count
        render json: { status: 'SUCCESS', data: count }
      end
    end
  end
end

