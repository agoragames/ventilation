
require 'net/http'
require 'uri'
require 'action_controller'
require 'ventilation/deep_stack'

module Ventilation
  module EsiHelper
    def esi(url_options)
      env = ENV['RAILS_ENV']
      if url_options[:action]
        # Internal
        case env
        when 'production'
          %%<esi:include src="#{url_for url_options}" max-age="0"/>%
        else
          if controller = url_options[:controller]
            controller = "#{controller.to_s.camelcase}Controller".constantize
          else
            controller = @controller.class
          end
          deep_stack = DeepStack.new(controller)
          action = url_options[:action]
          deep_stack.get(action).body
        end
      else
        # External
        case env
        when 'production'
          %%<esi:include src="#{url_options[:host]}#{url_options[:path]}" max-age="0"/>%
        else
          host = url_options[:host]
          path = url_options[:path]
          url = URI.parse(host)
          res = Net::HTTP.start(url.host, url.port) {|http|
            http.get(path)
          }
          res.body
        end

      end

    end

  end
end

# Include EsiHelper in the Application
module ApplicationHelper
  include Ventilation::EsiHelper
end
