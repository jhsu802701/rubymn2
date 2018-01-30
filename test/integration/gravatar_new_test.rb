require 'test_helper'

class GravatarNewTest < ActionDispatch::IntegrationTest
  test 'new user can sign up with a gravatar email address' do
    visit root_path
    click_on 'Sign up now!'
    fill_in('Last name', with: 'Norris')
    fill_in('First name', with: 'Chuck')
    fill_in('Username', with: 'cnorris')
    fill_in('Email', with: 'gmail@chucknorris.com')
    fill_in('Gravatar email', with: 'rails_in_windows@chucknorris.com')
    fill_in('Password', with: 'I push the Earth down!')
    fill_in('Password confirmation', with: 'I push the Earth down!')
    click_button('Sign up')

    open_email('gmail@chucknorris.com')
    current_email.click_link 'Confirm my account'
    login_user('gmail@chucknorris.com', 'I push the Earth down!', false)
    click_on 'Edit Settings'
    page.assert_selector(:xpath, xpath_input_str('rails_in_windows@chucknorris.com'))
  end
end
