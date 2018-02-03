require 'test_helper'

# rubocop:disable Metrics/BlockLength
class SponsorShowTest < ActionDispatch::IntegrationTest
  test 'displays the sponsor profile pages' do
    visit sponsor_path(@sponsor1)
    assert page.has_css?('title', text: full_title('Blessed Buy'), visible: false)
    assert page.has_css?('h1', text: 'Current Sponsor: Blessed Buy')
    assert_text '(612) 555-0101'
    assert_text 'THE place to buy the new Galaxy Wars merchandise'
    assert_text 'example@blessedbuy.com'
    assert page.has_link?('http://www.blessedbuy.com', href: 'http://www.blessedbuy.com')

    visit sponsor_path(@sponsor2)
    assert page.has_css?('title', text: full_title('Sky Store'), visible: false)
    assert page.has_css?('h1', text: 'Current Sponsor: Sky Store')
    assert_text '(800) 555-0102'
    assert_text 'If you fly, you can buy overpriced junk from our catalog.'
    assert_text 'example@skystore.com'
    assert page.has_link?('http://www.skystore.com', href: 'http://www.skystore.com')

    visit sponsor_path(@sponsor3)
    assert page.has_css?('title', text: full_title('Island Hoppers'), visible: false)
    assert page.has_css?('h1', text: 'Past Sponsor: Island Hoppers')
    assert_text '(808) 555-0103'
    assert_text 'I provide helicopter rides around the Hawaiian Islands.'
    assert_text 'tc@islandhoppers.com'
    assert page.has_link?('http://www.islandhoppers.com', href: 'http://www.islandhoppers.com')

    visit sponsor_path(@sponsor4)
    assert page.has_css?('title', text: full_title('Foundation for Law and Government'), visible: false)
    assert page.has_css?('h1', text: 'Past Sponsor: Foundation for Law and Government')
    assert_text '(800) 555-0104'
    assert_text 'We built Kitt.  Michael Knight and Kitt solve crimes.'
    assert_text 'devon_miles@flag.org'
    assert page.has_link?('http://www.flag.org', href: 'http://www.flag.org')
  end
end
# rubocop:enable Metrics/BlockLength
