require 'test_helper'

class ProjectIndexTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/BlockLength
  test 'The project index page has the expected content' do
    add_extra_projects
    visit projects_path
    assert_text 'Roger Moore'
    assert_text 'Live and Let Die'
    assert_text 'The Man with the Golden Gun'
    assert_text 'Pierce Brosnan'
    assert_text 'GoldenEye'
    assert_text 'Tomorrow Never Dies'
    assert_text 'Daniel Craig'
    assert_text 'Quantum of Solace'

    # Verify that index page provides access to profile pages
    assert page.has_css?('title', text: full_title('Project Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Project Index')
    assert page.has_link?('Live and Let Die', href: project_path(@p1))
    assert page.has_link?('The Man with the Golden Gun', href: project_path(@p2))
    assert page.has_link?('GoldenEye', href: project_path(@p3))
    assert page.has_link?('Tomorrow Never Dies', href: project_path(@p4))
    assert page.has_link?('Quantum of Solace', href: project_path(@p5))

    # Verify that the index page provides access to the source code and
    # deployed sites
    assert page.has_link?('https://github.com/rmoore/kananga',
                          href: 'https://github.com/rmoore/kananga')
    assert page.has_link?('http://www.kananga.com',
                          href: 'http://www.kananga.com')
    assert page.has_link?('https://github.com/rmoore/scaramanga',
                          href: 'https://github.com/rmoore/scaramanga')
    assert page.has_link?('http://www.scaramanga.com',
                          href: 'http://www.scaramanga.com')
    assert page.has_link?('ttps://github.com/pbrosnan/goldeneye',
                          href: 'https://github.com/pbrosnan/goldeneye')
    assert page.has_link?('http://www.goldeneye.com',
                          href: 'http://www.goldeneye.com')
    assert page.has_link?('https://github.com/pbrosnan/carver',
                          href: 'https://github.com/pbrosnan/carver')
    assert page.has_link?('http://www.carvernewsnetwork.com',
                          href: 'http://www.carvernewsnetwork.com')

    # Verify that root page provides access to index page
    click_on 'Home'
    assert page.has_link?('Projects', href: projects_path)

    # Verify that the second page of the index works
    click_on 'Projects'
    first(:link, '2').click
    assert page.has_css?('title', text: full_title('Project Index'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Project Index')
  end
  # rubocop:enable Metrics/BlockLength
end
