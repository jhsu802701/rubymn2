require 'test_helper'

class ForhireSearchTest < ActionDispatch::IntegrationTest
  test 'forhire search engine works' do
    add_extra_forhires
    visit forhires_path
    click_on 'For Hire'
    select 'Title', from: 'q[c][0][a][0][name]'
    select 'contains', from: 'q[c][0][p]'
    fill_in('q[c][0][v][0][value]', with: 'Daily stock market guru')
    click_on 'Search'
    assert page.has_css?('title', text: full_title('For Hire Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'For Hire Index')
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('For Hire Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'For Hire Index')
  end
end
