module Api
  module V1
    class SearchController < ApplicationController
      def index
        if (!params[:keyword]) then
          render json: { status: 'SUCCESS', data: "" }
          return
        end

        str = params[:keyword].strip
        if (str == "") then
          if (params[:software] != nil) then
            sites = Site.joins(:software).merge(Software.where(name: params[:software])).where.not(title: [nil, ""])
            if (params[:registration] != nil) then
              if (params[:registration] == "true") then
                sites = sites.where(registrations: true)
              end
            end
            sites = sites.where(optout: false)
            siteshash = sites.to_a
            result = []

            siteshash.each{|site|
              a = {}
              a[:uri] = site.uri
              a[:title] = Sanitize.clean(site.title)
              a[:short_description] = Sanitize.clean(site.short_description)
              a[:description] = Sanitize.clean(site.description)
              a[:registrations] = site.registrations
              result.append(a)
            }

            render json: { status: 'SUCCESS', data: result }
          else
            render json: { status: 'SUCCESS', data: "" }
          end
        else
          sites = Site.full_text_search(params[:keyword])
          if (params[:registration] != nil) then
            if (params[:registration] == "true") then
              sites = sites.where(registrations: true)
            end
          end
          if (params[:software] != nil) then
            sites = sites.joins(:software).merge(Software.where(name: params[:software]))
          end
          sites = sites.where(optout: false)
          sites = sites.where(dns_status: "NOERROR")
          siteshash = sites.to_a
          result = []
          
          siteshash.each{|site|
            a = {}
            a[:uri] = site.uri
            a[:title] = Sanitize.clean(site.title)
            a[:short_description] = Sanitize.clean(site.short_description)
            a[:description] = Sanitize.clean(site.description)
            a[:registrations] = site.registrations
            result.append(a)
          }

          render json: { status: 'SUCCESS', data: result }
        end
      end
    end
  end
end

