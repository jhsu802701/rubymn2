require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  test 'home page has expected content' do
    visit root_path
    assert page.has_css?('title', text: full_title(''), visible: false)
    assert page.has_css?('h1', text: 'Home')
    assert page.has_text?('Welcome to Ruby Users of Minnesota')
    assert page.has_css?('small', text: 'Ruby Users of Minnesota by Somebody')
  end

  test 'about page has expected content' do
    visit about_path
    assert page.has_css?('title', text: full_title('About'), visible: false)
    assert page.has_css?('h1', text: 'About')
    assert page.has_text?('Describe your site here.')
    assert page.has_css?('small', text: 'Ruby Users of Minnesota by Somebody')
  end

  test 'contact page has expected content' do
    visit contact_path
    assert page.has_css?('title', text: full_title('Contact'), visible: false)
    assert page.has_css?('h1', text: 'Contact')
    assert page.has_text?('rubyist@jasonhsu.com')
    assert page.has_css?('small', text: 'Ruby Users of Minnesota by Somebody')
  end

  test 'about page provides access to the home page' do
    visit about_path
    click_on 'Home'
    assert page.has_css?('title', text: full_title(''), visible: false)
    assert page.has_css?('h1', text: 'Home')
  end

  test 'contact page provides access to the home page' do
    visit contact_path
    click_on 'Home'
    assert page.has_css?('title', text: full_title(''), visible: false)
    assert page.has_css?('h1', text: 'Home')
  end
end
