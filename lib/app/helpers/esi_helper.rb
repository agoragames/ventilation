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
        when 'production', 'staging'
          %%<esi:include src="#{resource}" />%
        else
          url = URI.parse(resource)
          res = Net::HTTP.start(url.host, url.port) {|http|
            path = url.path.blank? ? "/" : url.path
            path = url.query ? "#{path}?#{url.query}" : path
            http.get(path)
          }
          res.body
        end
      else
        # ...otherwise render as an action.
        case env
        when 'production', 'staging'
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

    # Patch esi to make it return an html_safe string in rails 3
    if ::Rails::VERSION::MAJOR == 3
      alias :esi_unsafe :esi
      def esi(resource, options = {})
        esi_unsafe(resource, options).html_safe
      end
    end

  end
end

# Include EsiHelper in the Application
module ApplicationHelper
  include Ventilation::EsiHelper
end
