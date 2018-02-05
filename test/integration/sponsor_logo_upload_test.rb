require 'test_helper'

class SponsorLogoUploadTest < ActionDispatch::IntegrationTest
  # Xpath string used for testing for images
  def xpath_input_img(url)
    str1 = './/img[@src="'
    str2 = url
    str3 = '"]'
    output = "#{str1}#{str2}#{str3}"
    output
  end

  # rubocop:disable Metrics/AbcSize
  # fn: filename of image file
  def edit_logo(fn)
    basename = File.basename fn

    login_as(@a1, scope: :admin)
    visit sponsor_path(@sponsor1)
    click_on 'Edit Sponsor'
    find('form input[type="file"]').set(Rails.root + fn)
    click_button('Submit')

    assert page.has_text?('Sponsor updated')
    url = "/uploads/sponsor/picture/#{@sponsor1.id}/#{basename}"
    page.assert_selector(:xpath, xpath_input_img(url))
  end
  # rubocop:enable Metrics/AbcSize

  test 'super admin can add logo when creating sponsor' do
    login_as(@a1, scope: :admin)
    visit sponsors_path

    # Add current sponsor
    click_on 'Add Sponsor'
    assert page.has_css?('title', text: full_title('Add Sponsor'),
                                  visible: false)
    assert page.has_css?('h1', text: 'Add Sponsor')
    fill_in('Name', with: 'Debian Linux')
    fill_in('Phone', with: '800-555-1357')
    fill_in('Description', with: 'Universal operating system')
    fill_in('Email', with: 'info@debian.org')
    fill_in('URL', with: 'http://www.debian.org')
    check('Current')

    filename = 'app/assets/images/debian_logo.png'
    find('form input[type="file"]').set(Rails.root + filename)

    click_button('Submit')
    assert page.has_text?('Sponsor added')

    click_on 'Debian Linux'
    assert page.has_css?('h1', text: 'Current Sponsor: Debian Linux')

    s = Sponsor.find_by(name: 'Debian Linux')
    url = "/uploads/sponsor/picture/#{s.id}/debian_logo.png"
    page.assert_selector(:xpath, xpath_input_img(url))
  end

  test 'super admin can edit the sponsor logo' do
    f1 = 'app/assets/images/big_buy_logo.png'
    edit_logo(f1)
    f2 = 'app/assets/images/Best_Buy_Logo.png'
    edit_logo(f2)
  end
end
