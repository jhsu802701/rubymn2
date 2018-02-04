require 'test_helper'

class SponsorCreateTest < ActionDispatch::IntegrationTest
  def check_no_create_button
    visit sponsors_path
    assert page.has_no_link?('Add Sponsor', href: sponsors_path)
  end

  test 'visitor does not get button to add sponsor' do
    check_no_create_button
  end

  test 'user does not get button to add sponsor' do
    login_as(@u1, scope: :user)
    check_no_create_button
  end

  test 'regular admin does not get button to add sponsor' do
    login_as(@a4, scope: :admin)
    check_no_create_button
  end

  test 'super admin gets button to add sponsor' do
    login_as(@a1, scope: :admin)
    visit sponsors_path
    assert page.has_link?('Add Sponsor', href: new_sponsor_path)
  end

  # rubocop:disable Metrics/BlockLength
  test 'super admin can successfully add sponsors' do
    login_as(@a1, scope: :admin)
    visit sponsors_path

    # Add current sponsor
    click_on 'Add Sponsor'
    assert page.has_css?('title', text: full_title('Add Sponsor'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Sponsor')
    fill_in('Name', with: 'Richmond & Woods Law Offices')
    fill_in('Phone', with: '202-555-0111')
    fill_in('Description', with: 'Sassy and smart!')
    fill_in('Email', with: 'info@richmondwoods.com')
    fill_in('URL', with: 'http://www.richmondwoods.com')
    check('Current')

    click_button('Submit')
    assert page.has_text?('Sponsor added')

    click_on 'Richmond & Woods Law Offices'
    assert page.has_css?('h1', text: 'Current Sponsor: Richmond & Woods Law Offices')
    click_on 'Home'
    assert page.has_text?('Richmond & Woods Law Offices')

    # Add past sponsor
    click_on 'Sponsors'
    click_on 'Add Sponsor'
    assert page.has_css?('title', text: full_title('Add Sponsor'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Sponsor')
    fill_in('Name', with: 'Scrooge & Marley')
    fill_in('Phone', with: '020 7946 0123')
    fill_in('Description', with: 'Greedy misers!')
    fill_in('Email', with: 'ebenezer@scroogeandmarley.com')
    fill_in('URL', with: 'http://www.scroogeandmarley.com')

    click_button('Submit')
    assert page.has_text?('Sponsor added')

    click_on 'Scrooge & Marley'
    assert page.has_css?('h1', text: 'Past Sponsor: Scrooge & Marley')
    click_on 'Home'
    assert_not page.has_text?('Scrooge & Marley')
  end
  # rubocop:enable Metrics/BlockLength
end
