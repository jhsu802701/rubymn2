require 'test_helper'

class ForhireIndexTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/BlockLength
  test 'The forhire index page has the expected content' do
    add_extra_forhires
    visit forhires_path
    assert_text 'Sean Connery'
    assert_text 'I stopped Blofeld 4 times!'
    assert_text 'George Lazenby'
    assert_text 'I was James Bond for one movie.'
    assert_text 'Roger Moore'
    assert_text 'I made James Bond campier.'
    assert_text 'Timothy Dalton'
    assert_text 'I brought gritty realism to the Bond series.'
    assert_text 'Pierce Brosnan'
    assert_text 'James Bond moved beyond the Cold War Era on my watch.'
    assert_text 'Daniel Craig'
    assert_text 'I rebooted James Bond.'

    # Verify that index page provides access to profile pages
    assert page.has_css?('title', text: full_title('For Hire Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'For Hire Index')
    assert page.has_link?('James Bond 1962-1971', href: forhire_path(@fh_connery))
    assert page.has_link?('James Bond 1969', href: forhire_path(@fh_lazenby))
    assert page.has_link?('James Bond 1973-1985', href: forhire_path(@fh_moore))
    assert page.has_link?('James Bond 1987-1989', href: forhire_path(@fh_dalton))
    assert page.has_link?('James Bond 1995-2002', href: forhire_path(@fh_brosnan))
    assert page.has_link?('James Bond 2006-', href: forhire_path(@fh_craig))

    # Verify that root page provides access to index page
    click_on 'Home'
    assert page.has_link?('For Hire', href: forhires_path)

    # Verify that the second page of the index works
    click_on 'For Hire'
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('For Hire Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'For Hire Index')
  end
  # rubocop:enable Metrics/BlockLength
end
