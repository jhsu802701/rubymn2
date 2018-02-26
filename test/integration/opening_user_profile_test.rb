require 'test_helper'

class OpeningUserProfileTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def check_user_pages
    visit user_path(@u2)
    assert_not page.has_css?('h3', text: 'Job Openings')

    visit user_path(@u7)
    assert page.has_css?('h3', text: 'Job Openings')
    assert page.has_link?('Spacecraft Hijacker', href: opening_path(@op1))
    assert page.has_link?('Head of Unione Corse', href: opening_path(@op2))
    assert page.has_link?('Plastic Surgeon', href: opening_path(@op3))
    assert_text 'Hijack American and Soviet spacecraft'
    assert_text 'Run a European crime syndicate'
    assert_text 'Create fake versions of Blofeld to foil 007'

    visit user_path(@u11)
    assert page.has_css?('h3', text: 'Job Openings')
    assert page.has_link?('Deputy', href: opening_path(@op4))
    assert page.has_link?('Body Repair Technician', href: opening_path(@op5))
    assert_text 'Catch that black Trans Am!'
    assert_text 'Fix those police cars I keep wrecking'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def check_no_create_button
    visit users_path(@u4)
    assert page.has_no_link?('Add Job Opening', href: openings_path)
  end

  test 'user sees the expected content on pages' do
    login_as(@u1, scope: :user)
    check_user_pages
  end

  test 'regular admin sees the expected content on pages' do
    login_as(@a4, scope: :admin)
    check_user_pages
  end

  test 'super admin sees the expected content on pages' do
    login_as(@a1, scope: :admin)
    check_user_pages
  end

  test 'correct user can add openings' do
    login_as(@u5, scope: :user)
    visit user_path(@u5)
    click_on 'Add Job Opening'
    assert page.has_css?('title', text: full_title('Add Job Opening'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Job Opening')
    fill_in('Title', with: 'Intern')
    fill_in('Description', with: 'Support my volcanology research')
    click_button('Submit')
    assert text 'Intern'
    assert_text 'Support my volcanology research'
  end

  test 'wrong user does not get create button' do
    login_as(@u1, scope: :user)
    check_no_create_button
  end

  test 'regular admin does not get create button' do
    login_as(@a4, scope: :admin)
    check_no_create_button
  end

  test 'super admin does not get create button' do
    login_as(@a1, scope: :admin)
    check_no_create_button
  end
end
