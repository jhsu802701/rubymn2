require 'test_helper'

class OpeningSearchTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def opening_search_enabled
    add_extra_openings
    visit openings_path
    click_on 'Openings'
    select 'Title', from: 'q[c][0][a][0][name]'
    select 'contains', from: 'q[c][0][p]'
    fill_in('q[c][0][v][0][value]', with: 'Opening')
    click_on 'Search'
    assert page.has_css?('title', text: full_title('Job Opening Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Job Opening Index')
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('Job Opening Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Job Opening Index')
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  test 'user can search job openings' do
    login_as(@u1, scope: :user)
    opening_search_enabled
  end

  test 'regular admin can search job openings' do
    login_as(@a4, scope: :admin)
    opening_search_enabled
  end

  test 'super admin can search job openings' do
    login_as(@a1, scope: :admin)
    opening_search_enabled
  end
end
