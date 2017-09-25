# DriverManager returns driver for browser based on passed value. By default it is set to Firefox

require 'selenium-webdriver'

class DriverManager

  def self.driver(browser = :firefox)
    driver = Selenium::WebDriver.for browser
    case browser
      # add desired capabilities here
      # add path to the driver here
      when :firefox
      when :chrome
      when :ie
      when :safari
    end
    driver
  end

end