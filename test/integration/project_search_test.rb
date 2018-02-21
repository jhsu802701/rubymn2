require 'test_helper'

class ProjectSearchTest < ActionDispatch::IntegrationTest
  test 'project search engine works' do
    add_extra_projects
    visit projects_path
    click_on 'Projects'
    select 'Title', from: 'q[c][0][a][0][name]'
    select 'contains', from: 'q[c][0][p]'
    fill_in('q[c][0][v][0][value]', with: 'Project')
    click_on 'Search'
    assert page.has_css?('title', text: full_title('Project Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Project Index')
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('Project Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Project Index')
  end
end
