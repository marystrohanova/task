class Hooks 

  def self.driver
    @driver
  end

  def self.driver_open
    @driver = DriverManager.driver(:firefox)
    @driver.manage.delete_all_cookies
    @driver
  end

  def self.driver_close
    @driver.quit
  end

end