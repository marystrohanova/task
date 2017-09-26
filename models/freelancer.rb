class Freelancer
  attr_accessor :name, :title, :description, :skills

  def initialize(web_element)
    @web_element = web_element

    @name = @web_element.find_element(:xpath, './/h4//span').text
    @title = @web_element.find_element(:xpath, ".//h4[contains(@class, 'freelancer-tile-title')]").text
    @description = @web_element.find_element(:xpath, ".//div[@data-freelancer-description]").text
    @skills = @web_element.find_element(:xpath, ".//a[@data-log-label='tile_skill']").text
  end
end
