require 'net/http'
require 'uri'
require 'action_controller'
require 'ventilation/deep_stack'


module Ventilation
  module EsiHelper

    # Render resource on the edge
    def esi(resource, options = {})
      env = ENV['RAILS_ENV']

      # If we were passed a url...
      if resource =~ URI.regexp
        # ...fetch and render an external resource...
        case env
        when 'production'
          %%<esi:include src="#{resource}" />%
        else
          url = URI.parse(resource)
          res = Net::HTTP.start(url.host, url.port) {|http|
            path = url.query ? "#{url.path}?#{url.query}" : url.path
            http.get(path)
          }
          res.body
        end
      else
        # ...otherwise render as an action.
        case env
        when 'production'
          %%<esi:include src="#{url_for url_options.merge(:action => resource)}" />%
        else
          if controller = options[:controller]
            controller = "#{controller.to_s.camelcase}Controller".constantize
          else
            controller = @controller.class
          end
          deep_stack = DeepStack.new(controller)
          action = resource
          deep_stack.get(action).body
        end
      end
    end
  end
end

# Include EsiHelper in the Application
module ApplicationHelper
  include Ventilation::EsiHelper
end
