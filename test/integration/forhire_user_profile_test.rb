require 'test_helper'

class ForhireUserProfileTest < ActionDispatch::IntegrationTest
  def check_user_pages
    visit user_path(@u1)
    assert page.has_link?('James Bond 1962-1971', href: forhire_path(@fh_connery))
    visit user_path(@u2)
    assert page.has_link?('James Bond 1969', href: forhire_path(@fh_lazenby))
  end

  def check_no_create_button
    visit users_path(@u8)
    assert page.has_no_link?('Add For Hire Profile', href: forhires_path)
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

  test 'correct user without for hire can create for hire profile' do
    login_as(@u8, scope: :user)
    visit user_path(@u8)
    click_on 'Add For Hire Profile'
    assert page.has_css?('title', text: full_title('Add Your For Hire Profile'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Your For Hire Profile')
    fill_in('Title', with: 'Bandit')
    fill_in('Email', with: 'bandit@rubyonracetracks.com')
    fill_in('Background Statement', with: 'I can smuggle Coors Beer east bound and down!')
    click_button('Submit')
    assert page.has_css?('h3', text: 'Profile')
    assert_text 'I can smuggle Coors Beer east bound and down!'
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

  test 'user with for hire profile does not get create button' do
    login_as(@u1, scope: :user)
    check_no_create_button
  end
end
