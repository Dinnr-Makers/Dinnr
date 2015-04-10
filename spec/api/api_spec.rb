require "rubygems"
require "rack/test"
require "test/unit"

OUTER_APP = Rack::Builder.parse_file('config.ru').first

class DinnrTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  def test_serve_events
    get "/map.json"
    assert last_response.ok?
  end

end