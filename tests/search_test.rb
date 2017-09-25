require './pages/guest_page'
require './tests/test_base'
require './models/freelancer'
require 'yaml'
require 'pry'

class SearchTest < TestBase

  def test_search_for_freelancers
    @guest_page = GuestPage.new

    @guest_page.open
    assert(@guest_page.is_loaded?, 'Gues Page failed to load')

    @guest_page.fill_in_search_field(keyword)
    @guest_page.click_search_icon
    @guest_page.select_search_option('Freelancers')

    @search_results_page = @guest_page.submit_search
    assert(@search_results_page.is_loaded?, 'Search results page failed to load')
    @search_results_page.click_search_anywhere if @search_results_page.popup_present?
    @search_results_page.parse_freelancers
    @search_results_page.check_attrs_contain(keyword)

    @freelancer_profile_page = @search_results_page.open_freelancer(rand(10))
    assert(@freelancer_profile_page.is_loaded?, "Freelancer's profile page failed to load")
    assert(@freelancer_profile_page.check_name, "Actual freelancer's name did not matched expected")
    assert(@freelancer_profile_page.check_title, "Actual freelancer's title did not match expected")
    assert(@freelancer_profile_page.check_description, "Actual freelancer's name did not match expected")
    assert(@freelancer_profile_page.check_skills, "Actual freelancer's skills did not match expected")
    assert(@freelancer_profile_page.one_of_attribute_has('tester'), "None of stored freelancer's attributes contain word #{keyword}")
  end

  private

  def keyword
    YAML::load_file('./config/test.conf')['keyword']
  end
end
