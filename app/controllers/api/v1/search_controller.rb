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
            if (params[:minimumnumberofusers] != nil) then
              sites = sites.where("active_user >= ?", Integer(params[:minimumnumberofusers]))
            end

            sites = sites.where(optout: false)
            sites = sites.where(dns_status: "NOERROR")
            if (params[:software] != "other" && params[:software] != "writefreely" && params[:software] != "plume") then
              sites = sites.where.not(active_user: 0)
            end

            if (params[:sort] != nil) then
              if (params[:sort] == "uri") then
                if (params[:orderby] != nil && params[:orderby] == "desc") then
                  sites = sites.order(uri: :DESC)
                else
                  sites = sites.order(:uri)
                end
              elsif (params[:sort] == "title") then
                if (params[:orderby] != nil && params[:orderby] == "desc") then
                  sites = sites.order(title: :DESC)
                else
                  sites = sites.order(:title)
                end
              elsif (params[:sort] == "active_user") then
                if (params[:orderby] != nil && params[:orderby] == "desc") then
                  sites = sites.order(active_user: :DESC)
                else
                  sites = sites.order(:active_user)
                end
              end
            end

            siteshash = sites.to_a
            result = []

            siteshash.each{|site|
              a = {}
              a[:uri] = site.uri
              a[:title] = Sanitize.clean(site.title)
              a[:short_description] = Sanitize.clean(site.short_description)
              a[:description] = Sanitize.clean(site.description)
              a[:registrations] = site.registrations
              a[:total_user] = site.total_user
              a[:active_user] = site.active_user
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
          if (params[:minimumnumberofusers] != nil) then
            sites = sites.where("active_user >= ?", Integer(params[:minimumnumberofusers]))
          end
          sites = sites.where(optout: false)
          sites = sites.where(dns_status: "NOERROR")

          
          if (params[:sort] != nil) then
            if (params[:sort] == "uri") then
              if (params[:orderby] != nil && params[:orderby] == "desc") then
                sites = sites.order(uri: :DESC)
              else
                sites = sites.order(:uri)
              end
            elsif (params[:sort] == "title") then
              if (params[:orderby] != nil && params[:orderby] == "desc") then
                sites = sites.order(title: :DESC)
              else
                sites = sites.order(:title)
              end
            elsif (params[:sort] == "active_user") then
              if (params[:orderby] != nil && params[:orderby] == "desc") then
                sites = sites.order(active_user: :DESC)
              else
                sites = sites.order(:active_user)
              end
            end
          end
          siteshash = sites.to_a
          result = []
          
          siteshash.each{|site|
            if (site.active_user == 0) then
              if (site.software_id != 1 && site.software_id != 6 && site.software_id != 10) then
                next
              end
            end

            a = {}
            a[:uri] = site.uri
            a[:title] = Sanitize.clean(site.title)
            a[:short_description] = Sanitize.clean(site.short_description)
            a[:description] = Sanitize.clean(site.description)
            a[:registrations] = site.registrations
            a[:total_user] = site.total_user
            a[:active_user] = site.active_user
            result.append(a)
          }

          render json: { status: 'SUCCESS', data: result }
        end
      end
    end
  end
end

