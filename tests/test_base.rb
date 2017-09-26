require 'test/unit'
require './lib/driver_manager'
require './lib/hooks'
require './lib/steps_logger'

class TestBase < Test::Unit::TestCase

  # executes before each test
  def setup
    p "Start!"
    Hooks.driver_open
  end

  # executes after each test
  def teardown
    p "Exit!"
    Hooks.driver_close
  end
  
end