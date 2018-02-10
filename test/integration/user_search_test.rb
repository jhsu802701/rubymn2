require 'test_helper'

class UserSearchTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def search_users
    visit users_path
    click_on 'User Index'
    select 'Username', from: 'q[c][0][a][0][name]'
    select 'contains', from: 'q[c][0][p]'
    fill_in('q[c][0][v][0][value]', with: 'z_user')
    click_on 'Search'
    assert page.has_css?('title', text: full_title('User Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User Index')
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('User Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'User Index')
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  test 'user can search user index' do
    login_as(@u1, scope: :user)
    search_users
  end

  test 'regular admin can search user index' do
    login_as(@a4, scope: :admin)
    search_users
  end

  test 'super admin can search user index' do
    login_as(@a1, scope: :admin)
    search_users
  end
end
