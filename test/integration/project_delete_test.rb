require 'test_helper'

class ProjectDeleteTest < ActionDispatch::IntegrationTest
  def no_delete_button
    visit project_path(@p2)
    assert page.has_no_link?('Delete Project', href: project_path(@p2))
  end

  def gets_delete_button
    visit project_path(@p2)
    assert page.has_link?('Delete Project', href: project_path(@p2))
  end

  def can_delete
    gets_delete_button
    assert_difference 'Project.count', -1 do
      click_on 'Delete Project'
    end
    assert_text 'Project deleted'
    assert page.has_css?('title', text: full_title('User: Roger Moore'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User: Roger Moore',
                               visible: false)
  end

  test 'visitor does not get the delete button' do
    no_delete_button
  end

  test 'wrong user does not get the delete button' do
    login_as(@u1, scope: :user)
    no_delete_button
  end

  test 'right user gets the delete button' do
    login_as(@u3, scope: :user)
    gets_delete_button
  end

  test 'regular admin gets the delete button' do
    login_as(@a4, scope: :admin)
    gets_delete_button
  end

  test 'super admin gets the delete button' do
    login_as(@a1, scope: :admin)
    gets_delete_button
  end

  test 'right user can delete project' do
    login_as(@u3, scope: :user)
    can_delete
  end

  test 'regular admin can delete project' do
    login_as(@a4, scope: :admin)
    can_delete
  end

  test 'super admin can delete project' do
    login_as(@a1, scope: :admin)
    can_delete
  end
end
