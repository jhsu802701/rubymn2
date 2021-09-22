require 'test_helper'

class ForhireEditTest < ActionDispatch::IntegrationTest
  def check_no_edit_button
    visit forhire_path(@fh_connery)
    assert page.has_no_link?('Edit For Hire Profile', href: forhire_path(@fh_connery))
  end

  test 'visitor may not edit forhire' do
    check_no_edit_button
  end

  test 'wrong user may not edit forhire' do
    login_as(@u2, scope: :user)
    check_no_edit_button
  end

  test 'correct user gets button to edit forhire' do
    login_as(@u1, scope: :user)
    visit forhire_path(@fh_connery)
    assert page.has_link?('Edit For Hire Profile', href: edit_forhire_path(@fh_connery))
  end

  test 'regular admin may not edit forhire' do
    login_as(@a4, scope: :admin)
    check_no_edit_button
  end

  test 'super admin may not edit forhire' do
    login_as(@a1, scope: :admin)
    check_no_edit_button
  end

  # rubocop:disable Metrics/BlockLength
  test 'correct user can successfully edit forhire' do
    login_as(@u1, scope: :user)

    # Invalid forhire
    visit edit_forhire_path(@fh_connery)
    assert page.has_css?('title', text: full_title('Edit For Hire Profile'),
                                  visible: false)
    fill_in('Title', with: '')
    click_button('Submit')
    assert page.has_text?('The form contains 1 error.')
    assert page.has_text?("Title can't be blank")
    visit forhire_path(@fh_connery)
    assert page.has_css?('title',
                         text: full_title('Sean Connery: James Bond 1962-1971'),
                         visible: false)
    assert page.has_css?('h1', text: 'For Hire')
    assert_text 'I stopped Blofeld 4 times!'
    assert_text 'first_bond@rubyonracetracks.com'
    assert_text 'James Bond 1962-1971'

    # Valid forhire
    visit edit_forhire_path(@fh_connery)
    assert page.has_css?('title', text: full_title('Edit For Hire Profile'),
                                  visible: false)

    fill_in('Title', with: 'James Bond 1983')
    fill_in('Email', with: 'nsna@rubyonracetracks.com')
    fill_in('Background Statement', with: 'I stopped Largo twice!')

    click_button('Submit')
    assert page.has_css?('title',
                         text: full_title('Sean Connery: James Bond 1983'),
                         visible: false)
    assert page.has_css?('h1', text: 'For Hire')
    assert_text 'James Bond 1983'
    assert_text 'nsna@rubyonracetracks.com'
    assert_text 'I stopped Largo twice!'
  end
  # rubocop:enable Metrics/BlockLength
end
