class Freelancer
  attr_accessor :nokogiri

  def initialize(html)
    @html = html
    @nokogiri = Nokogiri::HTML(html)
  end

  def name
    @nokogiri.search("//h4//span").text
  end

  def title
    @nokogiri.search("//h4[contains(@class, 'freelancer-tile-title')]").text
  end

  def description
    @nokogiri.search("//div[@data-freelancer-description]").text
  end

  def skills
    @nokogiri.search("//a[@data-log-label='tile_skill']").text
  end
end
