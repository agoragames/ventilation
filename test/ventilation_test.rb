require 'test_helper'
require 'ventilation/deep_stack'

class TestVentilation < Test::Unit::TestCase

  context "a test consumer"do
    setup do
      FakeWeb.allow_net_connect = false
      @consumer = TestConsumer.new
    end

    should "render external resource" do
      expected = "response_from_example.com"
      FakeWeb.register_uri(:get, "http://example.com/", :body => expected)

      actual = @consumer.esi :host => 'http://example.com', :path => '/'
      # TODO: Replace with this synatx
      # actual = @consumer.esi 'http://example.com'

      assert_equal expected, actual, "Expected response was not rendered by esi method"
    end

    should "use DeepStack to render internal resource" do
      expected = 'rendered string'
      response = mock()
      response.expects(:body).returns(expected)
      deep_stack = mock()
      deep_stack.expects(:get).with(:index).returns(response)
      Ventilation::DeepStack.expects(:new).with(WelcomeController).returns(deep_stack)

      actual = @consumer.esi :controller => :welcome, :action => :index

      assert_equal expected, actual
    end

  end

end
 # A consumer of the ApplicationHelper for testing purposes.
class TestConsumer
  include ApplicationHelper
end

class WelcomeController
end
