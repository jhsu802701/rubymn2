require 'test_helper'

class FollowingButtonTest < ActionDispatch::IntegrationTest
  # NOTE: Visitors cannot access the user profile page (where the Follow/
  # Unfollow button is located).

  def no_follow_unfollow_button
    visit user_path(@u1)
    assert page.has_no_link?('Follow', href: user_path(@u1))
    assert page.has_no_link?('Unfollow', href: user_path(@u1))
  end

  test 'regular admin does not see the follow or unfollow buttons' do
    login_as(@a4, scope: :admin)
    no_follow_unfollow_button
  end

  test 'super admin does not see the follow or unfollow buttons' do
    login_as(@a1, scope: :admin)
    no_follow_unfollow_button
  end

  test 'user does not see the follow or unfollow buttons on own page' do
    login_as(@u1, scope: :user)
    no_follow_unfollow_button
  end

  test 'user can use the follow and unfollow buttons' do
    assert_difference '@u7.following.count', 1 do
      login_as(@u7, scope: :user)
      visit user_path(@u1)
      click_on 'Follow'
    end
    assert_difference '@u7.following.count', -1 do
      click_on 'Unfollow'
    end
    assert_difference '@u7.following.count', 1 do
      click_on 'Follow'
    end
  end
end
