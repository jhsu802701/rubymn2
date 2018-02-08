require 'test_helper'

class ForhireShowTest < ActionDispatch::IntegrationTest
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def check_forhire_pages
    visit forhire_path(@fh_connery)
    assert page.has_css?('title',
                         text: full_title('Sean Connery: James Bond 1962-1971'),
                         visible: false)
    assert page.has_css?('h1', text: 'For Hire')
    assert_text 'I stopped Blofeld 4 times!'
    assert_text 'first_bond@rubyonracetracks.com'
    assert_text 'James Bond 1962-1971'

    visit forhire_path(@fh_lazenby)
    assert page.has_css?('title',
                         text: full_title('George Lazenby: James Bond 1969'),
                         visible: false)
    assert page.has_css?('h1', text: 'For Hire')
    assert_text 'I was James Bond for one movie.'
    assert_text 'george_lazenby@rubyonracetracks.com'
    assert_text 'James Bond 1969'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def check_forhire_for_link
    visit forhire_path(@fh_connery)
    assert page.has_link?('Sean Connery', href: user_path(@u1))
    visit forhire_path(@fh_lazenby)
    assert page.has_link?('George Lazenby', href: user_path(@u2))
  end

  test 'visitor sees the expected content on pages' do
    check_forhire_pages
    visit forhire_path(@fh_connery)
    assert_not page.has_link?('Sean Connery', href: user_path(@u1))
    visit forhire_path(@fh_lazenby)
    assert_not page.has_link?('George Lazenby', href: user_path(@u2))
  end

  test 'user sees the expected content on pages' do
    login_as(@u1, scope: :user)
    check_forhire_pages
  end

  test 'regular admin sees the expected content on pages' do
    login_as(@a4, scope: :admin)
    check_forhire_pages
  end

  test 'super admin sees the expected content on pages' do
    login_as(@a1, scope: :admin)
    check_forhire_pages
  end
end
