require 'test_helper'

class OpeningDeleteTest < ActionDispatch::IntegrationTest
  def no_delete_button
    visit opening_path(@op4)
    assert page.has_no_link?('Delete Job Opening', href: opening_path(@op4))
  end

  def gets_delete_button
    visit opening_path(@op4)
    assert page.has_link?('Delete Job Opening', href: opening_path(@op4))
  end

  def can_delete
    gets_delete_button
    assert_difference 'Opening.count', -1 do
      click_on 'Delete Job Opening'
    end
    assert_text 'Job opening deleted'
    assert page.has_css?('title', text: full_title('User: Jackie Gleason'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User: Jackie Gleason',
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
    login_as(@u11, scope: :user)
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

  test 'right user can delete opening' do
    login_as(@u11, scope: :user)
    can_delete
  end

  test 'regular admin can delete opening' do
    login_as(@a4, scope: :admin)
    can_delete
  end

  test 'super admin can delete opening' do
    login_as(@a1, scope: :admin)
    can_delete
  end
end
