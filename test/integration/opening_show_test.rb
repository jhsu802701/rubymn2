require 'test_helper'

class OpeningShowTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def check_opening_pages
    visit opening_path(@op1)
    assert page.has_css?('title',
                         text: full_title('Job Opening: Spacecraft Hijacker'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Spacecraft Hijacker')
    assert_text 'Hijack American and Soviet spacecraft'
    assert page.has_link?('Ernst Blofeld', href: user_path(@u7))

    visit opening_path(@op2)
    assert page.has_css?('title',
                         text: full_title('Job Opening: Head of Unione Corse'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Head of Unione Corse')
    assert_text 'Run a European crime syndicate'
    assert page.has_link?('Ernst Blofeld', href: user_path(@u7))

    visit opening_path(@op3)
    assert page.has_css?('title',
                         text: full_title('Job Opening: Plastic Surgeon'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Plastic Surgeon')
    assert_text 'Create fake versions of Blofeld to foil 007'
    assert page.has_link?('Ernst Blofeld', href: user_path(@u7))

    visit opening_path(@op4)
    assert page.has_css?('title',
                         text: full_title('Job Opening: Deputy'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Deputy')
    assert_text 'Catch that black Trans Am!'
    assert page.has_link?('Jackie Gleason', href: user_path(@u11))

    visit opening_path(@op5)
    assert page.has_css?('title',
                         text: full_title('Job Opening: Body Repair Technician'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Body Repair Technician')
    assert_text 'Fix those police cars I keep wrecking'
    assert page.has_link?('Jackie Gleason', href: user_path(@u11))
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def check_redirect(proj)
    visit opening_path(proj)
    assert_text 'You must be logged in to view job openings.'
    assert page.has_css?('title', text: full_title('User Login'), visible: false)
    assert page.has_css?('h1', text: 'User Login')
  end

  test 'unregistered visitor is redirected to the user login page' do
    check_redirect(@op1)
    check_redirect(@op2)
    check_redirect(@op3)
    check_redirect(@op4)
    check_redirect(@op5)
  end

  test 'user sees the expected content on pages' do
    login_as(@u1, scope: :user)
    check_opening_pages
  end

  test 'regular admin sees the expected content on pages' do
    login_as(@a4, scope: :admin)
    check_opening_pages
  end

  test 'super admin sees the expected content on pages' do
    login_as(@a1, scope: :admin)
    check_opening_pages
  end
end
