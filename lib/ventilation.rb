require 'app/helpers/esi_helper'

if Rails::VERSION::MAJOR == 3
  module Ventilation
    attr esi
    class Railtie < Rails::Railtie
      initializer "ventilation.initialize" do |app|
        Ventilation.esi = app.esi
      end
    end
  end
end

# Include EsiHelper in the Application
module ApplicationHelper
  include Ventilation::EsiHelper
end


