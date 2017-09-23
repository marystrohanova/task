require './tests/test_base'
require './lib/hooks'
require 'nokogiri'
require 'open-uri'

class SearchResultsPage

  def initialize
    @driver = Hooks.driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 15)
  end

  def is_loaded
    @result_block = @wait.until { @driver.find_element(:id, "oContractorSearch") }
    @result_block.displayed?
  end

  def popup_present?
    @popup ||= @wait.until { @driver.find_element(:xpath, "//div[@class='modal-content']") }
  end

  def click_search_anywhere
    @button = @wait.until { @popup.find_element(:xpath, "//button[contains(text(), 'Search Anywhere')]") }
    @button.click
  end

  def find_10_rows
    @results = @wait.until { @driver.find_elements(:css, "article.row") }
    #e = @results.first
    #e.inner_HTML
    # t = @results.text
    # t.split("\n")
    #nok = Nokogiri::HTML(t)
    #freelancer_name = nok.search("//h4//span").text
    #attribute("innerHTML")
  end
end