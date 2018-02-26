require 'test_helper'

class OpeningIndexTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def opening_index_enabled
    add_extra_openings
    visit openings_path
    assert_text 'Hijack American and Soviet spacecraft'
    assert_text 'Run a European crime syndicate'
    assert_text 'Create fake versions of Blofeld to foil 007'
    assert_text 'Catch that black Trans Am!'
    assert_text 'Fix those police cars I keep wrecking'

    # Verify that index page provides access to opening profile pages
    assert page.has_css?('title', text: full_title('Opening Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Opening Index')
    assert page.has_link?('Spacecraft Hijacker', href: opening_path(@op1))
    assert page.has_link?('Head of Unione Corse', href: opening_path(@op2))
    assert page.has_link?('Plastic Surgeon', href: opening_path(@op3))
    assert page.has_link?('Deputy', href: opening_path(@op4))
    assert page.has_link?('Body Repair Technician', href: opening_path(@op5))

    # Verify that root page provides access to index page
    click_on 'Home'
    assert page.has_link?('Job Openings', href: openings_path)

    # Verify that the second page of the index works
    click_on 'Job Openings'
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('Job Opening Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Job Opening Index')
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  test 'unregistered visitor redirected to user login page' do
    get openings_path
    assert_redirected_to new_user_session_path
  end

  test 'user can view the opening index page' do
    login_as(@u1, scope: :user)
    opening_index_enabled
  end

  test 'regular admin can view the opening index page' do
    login_as(@a4, scope: :admin)
    opening_index_enabled
  end

  test 'super admin can view the opening index page' do
    login_as(@a1, scope: :admin)
    opening_index_enabled
  end
end
