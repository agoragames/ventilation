require 'net/http'
require 'uri'
require 'action_controller'
require 'ventilation/deep_stack'

module Ventilation
  module EsiHelper

    # Render resource on the edge
    def esi(resource, options = {})

      # If we were passed a url...
      if resource =~ URI.regexp
        # ...fetch and render an external resource...

        # If esi is enabled use it.
        if esi_enabled?
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
        if esi_enabled?
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

    # Helper for setting expire headers.
    #
    # Examples:
    #   <%- expire 5.minutes -%>
    #   <%- expire 30.seconds -%>
    def expire(duration)
      headers['Cache-Control'] = 'max-age=#{duration.to_i}'
      headers['Expires'] = duration.from_now.httpdate
    end

    private
    def esi_enabled?
      # HACK: The production/staging check is a hack until env specfic config can be added.
      # Enable esi if behind varnish.
      ["production", "staging"].include?(ENV['RAILS_ENV']) || request.env.has_key?('HTTP_X_VARNISH')
    end

  end
end

# Include EsiHelper in the Application
module ApplicationHelper
  include Ventilation::EsiHelper
end
