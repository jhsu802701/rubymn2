require 'test_helper'

class ProjectCreateTest < ActionDispatch::IntegrationTest
  def check_no_create_button
    visit projects_path
    assert page.has_no_link?('Add Project', href: projects_path)
  end

  test 'visitor does not get button to add project' do
    check_no_create_button
  end

  test 'user gets button to add project' do
    login_as(@u7, scope: :user)
    visit projects_path
    assert page.has_link?('Add Project', href: new_project_path)
  end

  test 'regular admin does not get button to add project' do
    login_as(@a4, scope: :admin)
    check_no_create_button
  end

  test 'super admin does not get button to add project' do
    login_as(@a1, scope: :admin)
    check_no_create_button
  end

  test 'user can successfully add project' do
    login_as(@u13, scope: :user)
    visit projects_path

    click_on 'Add Project'
    assert page.has_css?('title', text: full_title('Add Project'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Project')
    fill_in('Title', with: 'Smokey and the Bandit')
    fill_in('Source Code URL', with: 'https://github.com/hneedham/smokey_and_the_bandit')
    fill_in('Deployed URL', with: 'http://www.smokeyandthebandit.com')
    fill_in('Description', with: 'total lack of respect for the law')
    click_button('Submit')

    assert page.has_css?('title', text: full_title('User: Hal Needham'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User: Hal Needham')

    click_on 'Home'
    click_on 'Projects'
    assert page.has_css?('title', text: full_title('Project Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Project Index')
    assert_text 'Smokey and the Bandit'
    assert_text 'total lack of respect for the law'
    assert page.has_link?('https://github.com/hneedham/smokey_and_the_bandit',
                          href: 'https://github.com/hneedham/smokey_and_the_bandit')
    assert page.has_link?('http://www.smokeyandthebandit.com',
                          href: 'http://www.smokeyandthebandit.com')
  end
end
