require './pages/guest_page'
require './pages/search_results_page'
require './tests/test_base'
require './models/freelancer'
require 'pry'


class SearchTest < TestBase

  def test_search_for_freelancers
    @guest_page = GuestPage.new
    @search_results_page = SearchResultsPage.new

    @guest_page.open
    assert @guest_page.has_logo_displayed

    @guest_page.fill_in_search_field("tester")
    @guest_page.click_search_icon
    @guest_page.select_search_option("Freelancers")
    @guest_page.submit_search
    assert @search_results_page.is_loaded

    @search_results_page.click_search_anywhere if @search_results_page.popup_present?

    sleep(3)
    rows = @search_results_page.find_10_rows

    #assert_equal(10, rows.count, "actual count is: #{rows.count}")

    @freelancers = []
    rows.each do |row|
      @freelancers << Freelancer.new(row.attribute("innerHTML"))
    end
    binding.pry
  end
end

