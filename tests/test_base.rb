require 'test/unit'
require './lib/driver_manager'
require './lib/hooks'

class TestBase < Test::Unit::TestCase

  def setup
    p "Start!"
    Hooks.driver_open
  end

  def teardown
    p "Exit!"
    Hooks.driver_close
  end
  
end