require "rubygems"
require "rack/test"
require "test/unit"


class DinnrTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def test_serve_events
    get "/map.json"
    assert last_response.ok?
  end

end