require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title, 'Ruby Users of Minnesota'
    assert_equal full_title('About'), 'About | Ruby Users of Minnesota'
    assert_equal full_title('Contact'), 'Contact | Ruby Users of Minnesota'
    assert_equal full_title('Michael Hartl'), 'Michael Hartl | Ruby Users of Minnesota'
  end
end
