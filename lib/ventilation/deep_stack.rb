module Ventilation

  # Detect rails 2 or 3 by looking for TestProcess which
  # was removed in Rails 3.
  unless defined?(ActionController::TestProcess)
    # In Rails 3 the functionlity needed can be inherited
    # from TestCase.
    class DeepStack < ActionController::TestCase; end
  else
    # The Rails 2 the needed functionality can be included
    # from TestProcess.
    class DeepStack
      include ActionController::TestProcess
    end
  end

  # Simulate concurrency by serving request recursively.
  class DeepStack
    def initialize(controller_class)
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new

      @controller = controller_class.new

      if @controller
        @controller.request = @request
        @controller.params = {}
        @controller.send(:initialize_current_url)
      end
    end
  end


end
