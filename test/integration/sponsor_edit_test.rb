require 'test_helper'

class SponsorEditTest < ActionDispatch::IntegrationTest
  def check_no_edit_button
    visit sponsor_path(@sponsor1)
    assert page.has_no_link?('Edit Sponsor', href: sponsor_path(@sponsor1))
  end

  test 'visitor may not edit sponsor' do
    check_no_edit_button
  end

  test 'user may not edit sponsor' do
    login_as(@u1, scope: :user)
    check_no_edit_button
  end

  test 'regular admin may not edit sponsor' do
    login_as(@a4, scope: :admin)
    check_no_edit_button
  end

  test 'super admin gets button to edit sponsor' do
    login_as(@a1, scope: :admin)
    visit sponsor_path(@sponsor1)
    assert page.has_link?('Edit Sponsor', href: edit_sponsor_path(@sponsor1))
  end

  # rubocop:disable Metrics/BlockLength
  test 'super admin can successfully edit sponsors' do
    login_as(@a1, scope: :admin)
    visit edit_sponsor_path(@sponsor1)

    # Edit current sponsor
    assert page.has_css?('title', text: full_title('Edit Sponsor'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Edit Sponsor')
    fill_in('Name', with: 'King Kamehameha Club')
    fill_in('Phone', with: '808-555-0111')
    fill_in('Description', with: 'The beach club in _Magnum P.I._!')
    fill_in('Email', with: 'rick_wright@kingkamehamehaclub.com')
    fill_in('URL', with: 'http://www.kingkamehamehaclub.com')
    uncheck('Current')
    click_button('Submit')
    assert page.has_css?('h1', text: 'Past Sponsor: King Kamehameha Club')
    assert page.has_text?('808-555-0111')
    assert page.has_text?('The beach club in _Magnum P.I._!')
    assert page.has_text?('rick_wright@kingkamehamehaclub.com')
    assert page.has_text?('http://www.kingkamehamehaclub.com')
    assert page.has_text?('Sponsor updated')

    # Edit past sponsor
    visit edit_sponsor_path(@sponsor3)
    assert page.has_css?('title', text: full_title('Edit Sponsor'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Edit Sponsor')
    fill_in('Name', with: "Coop's Beer")
    fill_in('Phone', with: '888-555-0111')
    fill_in('Description', with: "parody of Coor's Beer")
    fill_in('Email', with: 'info@coopsbeer.com')
    fill_in('URL', with: 'http://www.coopsbeer.com')
    check('Current')
    click_button('Submit')
    assert page.has_css?('h1', text: "Current Sponsor: Coop's Beer")
    assert page.has_text?('888-555-0111')
    assert page.has_text?("parody of Coor's Beer")
    assert page.has_text?('info@coopsbeer.com')
    assert page.has_text?('http://www.coopsbeer.com')
    assert page.has_text?('Sponsor updated')
  end
  # rubocop:enable Metrics/BlockLength
end
