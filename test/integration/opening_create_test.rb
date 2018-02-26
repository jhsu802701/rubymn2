require 'test_helper'

class OpeningCreateTest < ActionDispatch::IntegrationTest
  def check_no_create_button
    visit openings_path
    assert page.has_no_link?('Add Job Opening', href: openings_path)
  end

  test 'user gets button to add opening' do
    login_as(@u7, scope: :user)
    visit openings_path
    assert page.has_link?('Add Job Opening', href: new_opening_path)
  end

  test 'regular admin does not get button to add opening' do
    login_as(@a4, scope: :admin)
    check_no_create_button
  end

  test 'super admin does not get button to add opening' do
    login_as(@a1, scope: :admin)
    check_no_create_button
  end

  test 'user can successfully add opening' do
    login_as(@u7, scope: :user)
    visit openings_path

    click_on 'Add Job Opening'
    assert page.has_css?('title', text: full_title('Add Job Opening'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Job Opening')
    fill_in('Title', with: 'Death Trap Builder')
    fill_in('Description', with: 'Build death traps that will kill 007!')
    click_button('Submit')

    assert page.has_css?('title', text: full_title('User: Ernst Blofeld'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User: Ernst Blofeld')

    click_on 'Home'
    click_on 'Job Openings'
    assert page.has_css?('title', text: full_title('Job Opening Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Job Opening Index')
    assert_text 'Death Trap Builder'
    assert_text 'Build death traps that will kill 007!'
  end
end
