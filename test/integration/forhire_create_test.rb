require 'test_helper'

class ForhireCreateTest < ActionDispatch::IntegrationTest
  def check_no_create_button
    visit forhires_path
    assert page.has_no_link?('Add For Hire Profile', href: forhires_path)
  end

  test 'visitor does not get button to add forhire' do
    check_no_create_button
  end

  test 'user with forhire profile does not get button to add forhire' do
    login_as(@u1, scope: :user)
    check_no_create_button
  end

  test 'user without forhire profile gets button to add forhire' do
    login_as(@u7, scope: :user)
    visit forhires_path
    assert page.has_link?('Add For Hire Profile', href: new_forhire_path)
  end

  test 'regular admin does not get button to add forhire' do
    login_as(@a4, scope: :admin)
    check_no_create_button
  end

  test 'super admin does not get button to add forhire' do
    login_as(@a1, scope: :admin)
    check_no_create_button
  end

  test 'user without forhire profile can successfully add forhire' do
    login_as(@u7, scope: :user)
    visit forhires_path

    click_on 'Add For Hire Profile'
    assert page.has_css?('title', text: full_title('Add Your For Hire Profile'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Your For Hire Profile')
    fill_in('Title', with: 'Master Villain')
    fill_in('Email', with: 'ernst_stavro_blofeld@example.com')
    fill_in('Background Statement', with: 'I am out to take over the world!')
    click_button('Submit')

    assert page.has_css?('title', text: full_title('User: Ernst Blofeld'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User: Ernst Blofeld')

    click_on 'Home'
    click_on 'For Hire'
    assert page.has_css?('title', text: full_title('For Hire Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'For Hire Index')
    assert_text 'Master Villain'
    assert_text 'ernst_stavro_blofeld@example.com'
    assert_text 'I am out to take over the world!'
  end
end
