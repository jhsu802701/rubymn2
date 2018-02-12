require 'test_helper'

class ForhireDeleteTest < ActionDispatch::IntegrationTest
  def no_delete_button
    visit forhire_path(@fh_lazenby)
    assert page.has_no_link?('Delete For Hire Profile', href: forhire_path(@fh_lazenby))
  end

  def gets_delete_button
    visit forhire_path(@fh_lazenby)
    assert page.has_link?('Delete For Hire Profile', href: forhire_path(@fh_lazenby))
  end

  def can_delete
    gets_delete_button
    assert_difference 'Forhire.count', -1 do
      click_on 'Delete For Hire Profile'
    end
    assert_text 'For hire profile deleted'
    assert page.has_css?('title', text: full_title('User: George Lazenby'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User: George Lazenby',
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
    login_as(@u2, scope: :user)
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

  test 'right user can delete forhire' do
    login_as(@u2, scope: :user)
    can_delete
  end

  test 'regular admin can delete forhire' do
    login_as(@a4, scope: :admin)
    can_delete
  end

  test 'super admin can delete forhire' do
    login_as(@a1, scope: :admin)
    can_delete
  end
end
