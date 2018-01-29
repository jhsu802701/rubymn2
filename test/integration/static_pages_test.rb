require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  test 'home page has expected content' do
    visit root_path
    assert page.has_css?('title', text: full_title(''), visible: false)
    assert page.has_css?('h1', text: 'Home')
    assert page.has_text?('Welcome to Ruby Users of Minnesota')
    assert page.has_css?('small', text: 'Ruby Users of Minnesota')

    assert page.has_css?('small', text: Time.now.year.to_s)
    assert page.has_link?('Heroku', href: 'https://www.heroku.com')
    assert page.has_text?('We are Ruby enthusiasts from the Twin Cities area.')
    assert page.has_link?('https://www.meetup.com/ruby-mn', href: 'https://www.meetup.com/ruby-mn')
    assert page.has_link?('https://twitter.com/rubymn', href: 'https://twitter.com/rubymn')
    assert page.has_link?('https://groups.google.com/forum/#!forum/rubymn', href: 'https://groups.google.com/forum/#!forum/rubymn')
    assert page.has_link?('https://www.dayblockbrewing.com', href: 'https://www.dayblockbrewing.com')
  end
end
