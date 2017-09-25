class FreelancerProfilePage

  def initialize(freelancer)
    @driver = Hooks.driver
    @wait   = Selenium::WebDriver::Wait.new(timeout: 15)
    @logger = StepsLogger.new
    @freelancer = freelancer
  end

  def is_loaded?
    @logger.write('Check freelancer profile page is open')
    @wait.until { @driver.find_element(:id, 'oProfilePage') }
  end

  def description
    @description ||= @wait.until { @driver.find_elements(:xpath, "//p[@itemprop='description']").last }
  end

  def skills
    @skills ||= @wait.until { @driver.find_element(:xpath, "//div[@class='fe-profile-header-skills']//div[contains(@class, 'o-profile-skills')]") }
  end

  def title
    @title = @wait.until { @driver.find_element(:xpath, "//span[contains(@class, 'fe-job-title')]") }
  end

  def check_name
    @logger.write('Check that name value is equal to stored')
    name = @wait.until { @driver.find_element(:xpath, "//h2//span//span[@itemprop='name']") }
    name.text.include?(@freelancer.name)
  end

  def check_title
    @logger.write('Check that title value is equal to stored')
    title.text.include?(@freelancer.title)
  end

  def check_description
    @logger.write('Check that description value is equal to stored')
    description.text.gsub("\n", '').squeeze(' ').include?(@freelancer.description.gsub("\n", '').squeeze(' ').gsub(' ...', ''))
  end

  def check_skills
    @logger.write('Check that skills value is equal to stored')
    skills.text.include?(@freelancer.skills.squeeze(' '))
  end

  def one_of_attribute_has(keyword)
    @logger.write("Check that at least one of attributes contain keyword: '#{keyword}'")
    title_contains_kword = title.text.downcase.include?(keyword)
    @logger.write("Title contains #{keyword}: #{!!title_contains_kword}")

    expand_description
    description_contains_kword = description.text.downcase.include?(keyword)
    @logger.write("Description contains #{keyword}: #{!!description_contains_kword}")

    expand_skills
    skills_contains_kword = skills.text.downcase.include?(keyword)
    @logger.write("Skills contain #{keyword}: #{!!skills_contains_kword}")

    @logger.write("No matches!", false) if !title_contains_kword && !description_contains_kword && !skills_contains_kword
    @logger.write("\n", false)

    title_contains_kword || description_contains_kword || skills_contains_kword
  end

  def expand_description
    more_link = description.find_element(:link_text, 'more')
    unless more_link.nil?
      @logger.write("Expand description section if 'more' link is present")

      more_link.click   
      @wait.until { @driver.find_element(:xpath, "//p[@itemprop='description']//span[@class='ng-scope ng-hide']") }
    end
  end

  def expand_skills
    skills_more_link = skills.find_elements(:xpath, "//span[contains(@class, 'btn-link')]").last
    unless skills_more_link.nil?
      @logger.write("Expand skills section if 'more' link is present")
      skills_more_link.click
    end
  end

end
