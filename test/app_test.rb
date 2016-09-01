ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "pry"
require_relative "../app.rb"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
  end

  def teardown
  end

  def test_index_has_greeting
    get "/"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "Hello, World!"
  end
end
