require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  test 'home page has expected content' do
    visit root_path
    assert page.has_css?('title', text: full_title(''), visible: false)
    assert page.has_css?('h1', text: 'Home')
    assert page.has_text?('Welcome to Ruby Users of Minnesota')
    assert page.has_css?('small', text: 'Ruby Users of Minnesota by Somebody')
  end

  test 'contact page provides access to the home page' do
    visit contact_path
    click_on 'Home'
    assert page.has_css?('title', text: full_title(''), visible: false)
    assert page.has_css?('h1', text: 'Home')
  end
end
