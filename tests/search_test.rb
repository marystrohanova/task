require './pages/guest_page'
require './tests/test_base'

class SearchTest < TestBase

  def test_openURL
    guest_page = GuestPage.new
    guest_page.open
    assert guest_page.has_logo_displayed
  end

  def test_openURL1
    guest_page = GuestPage.new
    guest_page.open
    assert guest_page.has_logo_displayed
  end
end

