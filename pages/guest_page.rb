require './tests/test_base'
require './lib/hooks'

class GuestPage


  def initialize
    @driver = Hooks.driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 15)
  end

  def open
    @driver.navigate.to "http://upwork.com/"
  end

  def has_logo_displayed
    @driver.find_element(:xpath, "//img[@alt='Upwork']").displayed?
  end

  def fill_in_search_field(string)
    @search_field.send_keys(string) unless search_field.nil?
  end

  def click_search_icon
    @search_icon.click unless search_icon.nil?
  end

  def select_search_option(option)
    xpath = "//div[@class='dropdown active']//label[contains(text(), '" + option + "')]"
    @driver.find_element(:xpath, xpath).click unless search_options.nil?
  end

  def submit_search
    @search_field.submit
  end

  private

  def search_field
    @search_field = @wait.until { @driver.find_element(:id, "q") }
  end

  def search_icon
    @search_icon = @wait.until { @driver.find_element(:xpath, "//form[@role='search']//span") }
  end

  def search_options
    @search_options = @wait.until { @driver.find_element(:xpath, "//form[@role='search']//div[@class='dropdown active']") }
  end

end
