require 'test_helper'

class ProjectShowTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def check_project_pages
    visit project_path(@p1)
    assert page.has_css?('title',
                         text: full_title('Project: Live and Let Die'),
                         visible: false)
    assert page.has_css?('h1', text: 'Project: Live and Let Die')
    assert_text 'Investigate Kananga.'
    assert_text 'Source Code URL:'
    assert_text 'Deployed URL:'
    assert page.has_link?('https://github.com/rmoore/kananga',
                          href: 'https://github.com/rmoore/kananga')
    assert page.has_link?('http://www.kananga.com',
                          href: 'http://www.kananga.com')

    visit project_path(@p2)
    assert page.has_css?('title',
                         text: full_title('The Man with the Golden Gun'),
                         visible: false)
    assert page.has_css?('h1', text: 'Project: The Man with the Golden Gun')
    assert_text 'Get the Solex Agitator from Scaramanga.'
    assert_text 'Source Code URL:'
    assert_text 'Deployed URL:'
    assert page.has_link?('https://github.com/rmoore/scaramanga',
                          href: 'https://github.com/rmoore/scaramanga')
    assert page.has_link?('http://www.scaramanga.com',
                          href: 'http://www.scaramanga.com')

    visit project_path(@p3)
    assert page.has_css?('title',
                         text: full_title('GoldenEye'),
                         visible: false)
    assert page.has_css?('h1', text: 'Project: GoldenEye')
    assert_text 'Stop the hijacking of the GoldenEye satellite.'
    assert_text 'Source Code URL:'
    assert_text 'Deployed URL:'
    assert page.has_link?('ttps://github.com/pbrosnan/goldeneye',
                          href: 'https://github.com/pbrosnan/goldeneye')
    assert page.has_link?('http://www.goldeneye.com',
                          href: 'http://www.goldeneye.com')

    visit project_path(@p4)
    assert page.has_css?('title',
                         text: full_title('Project: Tomorrow Never Dies'),
                         visible: false)
    assert page.has_css?('h1', text: 'Project: Tomorrow Never Dies')
    assert_text 'Prevent war between China and the UK.'
    assert_text 'Source Code URL:'
    assert_text 'Deployed URL:'
    assert page.has_link?('https://github.com/pbrosnan/carver',
                          href: 'https://github.com/pbrosnan/carver')
    assert page.has_link?('http://www.carvernewsnetwork.com',
                          href: 'http://www.carvernewsnetwork.com')

    visit project_path(@p5)
    assert page.has_css?('title',
                         text: full_title('Project: Quantum of Solace'),
                         visible: false)
    assert page.has_css?('h1', text: 'Project: Quantum of Solace')
    assert_text 'Get revenge for the death of Vesper Lynd.'
    assert_not page.has_text?('Source Code URL:')
    assert_not page.has_text?('Deployed URL:')
  end
  # rubocop:enable Metrics/MethodLength

  def check_project_for_link
    visit project_path(@p1)
    assert page.has_link?('Roger Moore', href: user_path(@u3))
    visit project_path(@p2)
    assert page.has_link?('Roger Moore', href: user_path(@u3))
    visit project_path(@p3)
    assert page.has_link?('Pierce Brosnan', href: user_path(@u5))
    visit project_path(@p4)
    assert page.has_link?('Pierce Brosnan', href: user_path(@u5))
    visit project_path(@p5)
    assert page.has_link?('Daniel Craig', href: user_path(@u6))
  end
  # rubocop:enable Metrics/AbcSize

  test 'visitor sees the expected content on pages' do
    check_project_pages
    visit project_path(@p1)
    assert_not page.has_link?('Roger Moore', href: user_path(@u3))
    visit project_path(@p2)
    assert_not page.has_link?('Roger Moore', href: user_path(@u3))
    visit project_path(@p3)
    assert_not page.has_link?('Pierce Brosnan', href: user_path(@u5))
    visit project_path(@p4)
    assert_not page.has_link?('Pierce Brosnan', href: user_path(@u5))
    visit project_path(@p5)
    assert_not page.has_link?('Daniel Craig', href: user_path(@u6))
  end

  test 'user sees the expected content on pages' do
    login_as(@u1, scope: :user)
    check_project_pages
    check_project_for_link
  end

  test 'regular admin sees the expected content on pages' do
    login_as(@a4, scope: :admin)
    check_project_pages
    check_project_for_link
  end

  test 'super admin sees the expected content on pages' do
    login_as(@a1, scope: :admin)
    check_project_pages
    check_project_for_link
  end
end
