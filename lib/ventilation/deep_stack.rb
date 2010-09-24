module Ventilation
  # Simulate concurrency by serving request recursively.
  class DeepStack
    include ActionController::TestProcess

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
