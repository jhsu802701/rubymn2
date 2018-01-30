require 'test_helper'

class GravatarEditTest < ActionDispatch::IntegrationTest
  test 'user edit page provides a link to editing the gravatar' do
    login_as(@u1, scope: :user)
    visit root_path
    click_on 'Edit Settings'
    assert page.has_link?('Edit Gravatar', href: 'http://gravatar.com/emails')
  end

  test 'user can edit gravatar_email' do
    g_email = 'henry_jones@example.com'
    login_as(@u1, scope: :user)
    visit root_path
    click_on 'Edit Settings'
    fill_in('Gravatar email', with: g_email)
    fill_in('Current password', with: 'Goldfinger')
    click_button('Update')
    assert page.has_text?('Your account has been updated successfully.')
    click_on 'Edit Settings'
    page.assert_selector(:xpath, xpath_input_str(g_email))
  end
end
