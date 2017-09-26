require './tests/test_base'
require './lib/hooks'
require './pages/search_results_page'
require './lib/steps_logger'

class GuestPage
  def initialize
    @driver = Hooks.driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 15)
    @logger = StepsLogger.new
  end

  def open
    @logger.write('Navigate to Upwork')
    @driver.navigate.to "http://upwork.com/"
  end

  def is_loaded?
    @logger.write('Check guest page is open')
    @wait.until { @driver.find_element(:partial_link_text, "Get Started") }
  end

  def fill_in_search_field(string)
    @logger.write("Fill in search field: #{string}")
    @search_field.send_keys(string) unless search_field.nil?
  end

  def click_search_icon
    @logger.write("Click on magnifying glass")
    search_icon.click unless search_icon.nil?
  end

  def select_search_option(option)
    @logger.write("Select #{option} in search dropwown menu")

    xpath = "//div[@class='dropdown active']//label[contains(text(), '" + option + "')]"
    @driver.find_element(:xpath, xpath).click unless search_options.nil?
  end

  def submit_search
    @logger.write('Submit search')
    @search_field.submit

    SearchResultsPage.new
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
