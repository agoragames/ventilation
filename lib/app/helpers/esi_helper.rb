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
      if resource =~ /^(http:\/\/)?[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu)[a-zA-Z0-9\-\.\/]+$/i
        # ...fetch and render an external resource...
        case env
        when 'production'
          %%<esi:include src="#{resource}" />%
        else
          url = URI.parse(resource)
          res = Net::HTTP.start(url.host, url.port) {|http|
            http.get(url.path)
          }
          res.body
        end
      else
        # ...otherwise render as an action.
        case env
        when 'production'
          %%<esi:include src="#{url_for url_options}" />%
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
