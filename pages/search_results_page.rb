require './tests/test_base'
require './lib/hooks'
require './lib/steps_logger'
require './pages/freelancer_profile_page'
require 'nokogiri'
require 'open-uri'

class SearchResultsPage

  def initialize
    @driver = Hooks.driver
    @wait   = Selenium::WebDriver::Wait.new(timeout: 15)
    @logger = StepsLogger.new
  end

  def is_loaded?
    @logger.write('Check search results page is open')
    @result_block = @wait.until { @driver.find_element(:id, "oContractorSearch") }
    @result_block.displayed?
  end

  def popup_present?
    @logger.write('Wait for location search suggestion popup to appear')
    sleep(3)
    @popup ||= @wait.until { @driver.find_element(:xpath, "//div[@class='modal-content']") }
  end

  def click_search_anywhere
    @logger.write('Click on button Search Anywhere')
    @button = @wait.until { @popup.find_element(:xpath, "//button[contains(text(), 'Search Anywhere')]") }
    @button.click
  end

  # get all freelansers from 1st result page and parse attributes
  def parse_freelancers
    sleep(3)
    @rows = @wait.until { @driver.find_elements(:css, "article.row") }

    @freelancers = []
    @rows.each do |row|
      @freelancers << Freelancer.new(row.attribute("innerHTML"))
    end
  end

  def check_attrs_contain(kword)
    keyword = kword.downcase
    @logger.write("Check whether freelancer attributes contain keyword '#{keyword}' or not")

    @freelancers.each do |freelancer|
      @logger.write("Freelancer #{freelancer.name}", false)

      title_contains_kword = freelancer.title.downcase.include?(keyword)
      description_contains_kword = freelancer.description.downcase.include?(keyword)
      skills_contains_kword = freelancer.skills.downcase.include?(keyword)

      @logger.write("Title contains #{keyword}: #{!!title_contains_kword}", false)
      @logger.write("Description contains: #{keyword}: #{!!description_contains_kword}", false)
      @logger.write("Skills contain #{keyword}: #{!!skills_contains_kword}", false)

      @logger.write("No matches!", false) if !title_contains_kword && !description_contains_kword && !skills_contains_kword
      @logger.write("\n", false)
    end
  end

  def open_freelancer(number)
    @logger.write("Open random freelancer: #{number}")
    freelancer = @rows[number]
    freelancer.location_once_scrolled_into_view

    freelancer.click
    FreelancerProfilePage.new(@freelancers[number])
  end

end