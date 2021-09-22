require 'test_helper'

class OpeningEditTest < ActionDispatch::IntegrationTest
  def check_no_edit_button
    visit opening_path(@op4)
    assert page.has_no_link?('Edit Job Opening', href: opening_path(@op4))
  end

  test 'visitor may not edit opening' do
    check_no_edit_button
  end

  test 'wrong user may not edit opening' do
    login_as(@u2, scope: :user)
    check_no_edit_button
  end

  test 'correct user gets button to edit opening' do
    login_as(@u11, scope: :user)
    visit opening_path(@op4)
    assert page.has_link?('Edit Job Opening', href: edit_opening_path(@op4))
  end

  test 'regular admin may not edit opening' do
    login_as(@a4, scope: :admin)
    check_no_edit_button
  end

  test 'super admin may not edit opening' do
    login_as(@a1, scope: :admin)
    check_no_edit_button
  end

  # rubocop:disable Metrics/BlockLength
  test 'correct user can successfully edit opening' do
    login_as(@u11, scope: :user)

    # Invalid edit of job opening
    visit edit_opening_path(@op4)
    assert page.has_css?('title', text: full_title('Edit Job Opening'),
                                  visible: false)
    fill_in('Title', with: '')
    click_button('Submit')
    assert page.has_text?('The form contains 1 error.')
    assert page.has_text?("Title can't be blank")
    visit opening_path(@op4)
    assert page.has_css?('title',
                         text: full_title('Job Opening: Deputy'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Deputy')
    assert_text 'Catch that black Trans Am!'
    assert page.has_link?('Jackie Gleason', href: user_path(@u11))

    # Valid edit of job opening
    visit edit_opening_path(@op4)
    assert page.has_css?('title', text: full_title('Edit Job Opening'),
                                  visible: false)
    fill_in('Title', with: 'Lawyer')
    fill_in('Description', with: 'Defend me from lawsuits')
    click_button('Submit')

    assert page.has_css?('title',
                         text: full_title('Job Opening: Lawyer'),
                         visible: false)
    assert page.has_css?('h1', text: 'Job Opening: Lawyer')
    assert_text 'Defend me from lawsuits'
  end
  # rubocop:enable Metrics/BlockLength
end
