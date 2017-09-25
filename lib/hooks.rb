# Driver is used in PageObjects classes only. 
# open/close methods are used in TestBase to manage driver state before and after each test

require './lib/steps_logger'
require 'yaml'

class Hooks 

  def self.driver
    @driver
  end

  def self.driver_open
    clear_logs
    logger.write('Open browser')
    @driver = DriverManager.driver(browser)
    logger.write('Clear browser cookies')
    @driver.manage.delete_all_cookies
    @driver
  end

  def self.driver_close
    logger.write('Close browser')
    @driver.quit
  end

  private

  def self.clear_logs
    logger.clear_all
  end

  def self.logger
    @logger ||= StepsLogger.new
  end

  def self.browser
    YAML::load_file('./config/test.conf')['browser'].to_sym || :firefox
  end
end