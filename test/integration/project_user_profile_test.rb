require 'test_helper'

class ProjectUserProfileTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  def check_user_pages
    visit user_path(@u2)
    assert_not page.has_css?('h3', text: 'Projects')
    visit user_path(@u3)
    assert page.has_css?('h3', text: 'Projects')
    assert page.has_link?('Live and Let Die', href: project_path(@p1))
    assert page.has_link?('The Man with the Golden Gun', href: project_path(@p2))
    visit user_path(@u5)
    assert page.has_css?('h3', text: 'Projects')
    assert page.has_link?('GoldenEye', href: project_path(@p3))
    assert page.has_link?('Tomorrow Never Dies', href: project_path(@p4))
  end
  # rubocop:enable Metrics/AbcSize

  def check_no_create_button
    visit users_path(@u4)
    assert page.has_no_link?('Add Project', href: projects_path)
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

  test 'correct user can add projects' do
    login_as(@u4, scope: :user)
    visit user_path(@u4)
    click_on 'Add Project'
    assert page.has_css?('title', text: full_title('Add Project'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Project')
    fill_in('Title', with: 'The Living Daylights')
    fill_in('Source Code URL', with: 'https://github.com/tdalton/tld')
    fill_in('Deployed URL', with: 'http://www.livingdaylights.com')
    fill_in('Description', with: 'Help Koskov defect from the USSR!')
    click_button('Submit')
    assert_text 'The Living Daylights'
    assert_text 'Help Koskov defect from the USSR!'
    assert page.has_link?('https://github.com/tdalton/tld',
                          href: 'https://github.com/tdalton/tld')
    assert page.has_link?('http://www.livingdaylights.com',
                          href: 'http://www.livingdaylights.com')
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
