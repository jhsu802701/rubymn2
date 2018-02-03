require 'test_helper'

class SponsorIndexTest < ActionDispatch::IntegrationTest
  test 'The sponsor index page has the expected content' do
    visit sponsors_path
    assert page.has_css?('title', text: full_title('Sponsor Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Sponsor Index')
    assert page.has_link?('Blessed Buy', href: sponsor_path(@sponsor1))
    assert page.has_link?('Sky Store', href: sponsor_path(@sponsor2))
    assert page.has_link?('Island Hoppers', href: sponsor_path(@sponsor3))
    assert page.has_link?('Foundation for Law and Government', href: sponsor_path(@sponsor4))
  end

  test 'The header provides access to the sponsor index page' do
    visit root_path
    assert page.has_link?('Sponsors', href: sponsors_path)
  end

  test 'The home page lists the current sponsors' do
    visit root_path
    assert page.has_link?('Blessed Buy', href: sponsor_path(@sponsor1))
    assert page.has_link?('Sky Store', href: sponsor_path(@sponsor2))
  end
end
