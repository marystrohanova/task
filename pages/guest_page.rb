require './tests/test_base'
require './lib/hooks'

class GuestPage

  def initialize
    @driver = Hooks.driver
  end

  def open
    @driver.navigate.to "http://upwork.com/"
  end

  def has_logo_displayed
    @driver.find_element(:xpath, "//img[@alt='Upwork']").displayed?
  end

end
