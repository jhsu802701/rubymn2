require 'test_helper'

class UserFollowingTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  def can_view_users_following
    assert page.has_link?('breynolds', href: user_path(@u8))
    assert page.has_link?('jreed', href: user_path(@u9))
    assert page.has_link?('sfield', href: user_path(@u10))
    assert page.has_link?('jgleason', href: user_path(@u11))
    assert page.has_link?('mhenry', href: user_path(@u12))
  end
  # rubocop:enable Metrics/AbcSize

  test 'visitors cannot view the user following page' do
    visit following_user_path(@u13)
    assert page.has_css?('title', text: full_title(''),
                                  visible: false)
    assert page.has_css?('h1', text: 'Home', visible: false)
  end

  test "user cannot view another user's following page" do
    login_as(@u12, scope: :user)
    visit following_user_path(@u13)
    assert page.has_css?('title', text: full_title(''),
                                  visible: false)
    assert page.has_css?('h1', text: 'Home', visible: false)
  end

  test "user does not get link to another user's following page" do
    login_as(@u12, scope: :user)
    visit user_path(@u13)
    assert_not page.has_text?('Following')
  end

  test 'user following other users can access own following page through home page' do
    login_as(@u13, scope: :user)
    visit root_path
    assert page.has_text?('Following: 5')
    assert page.has_link?('Following: 5', href: following_user_path(@u13))
  end

  test 'user can access own following page through own profile page' do
    login_as(@u13, scope: :user)
    visit root_path
    click_on 'Your Profile'
    assert page.has_link?('Following: 5', href: following_user_path(@u13))
  end

  test 'user can view own list of users followed' do
    login_as(@u13, scope: :user)
    visit following_user_path(@u13)
    assert page.has_css?('h1', text: 'Users You Are Following')
    can_view_users_following
  end

  test 'regular admin can see the list of users followed' do
    login_as(@a4, scope: :admin)
    visit user_path(@u13)
    assert page.has_link?('Following: 5', href: following_user_path(@u13))
    click_on 'Following: 5'
    assert page.has_css?('h1', text: 'Users Followed By Hal Needham')
    can_view_users_following
  end

  test 'super admin can see the list of users followed' do
    login_as(@a1, scope: :admin)
    visit user_path(@u13)
    assert page.has_link?('Following: 5', href: following_user_path(@u13))
    click_on 'Following: 5'
    assert page.has_css?('h1', text: 'Users Followed By Hal Needham')
    can_view_users_following
  end
end
