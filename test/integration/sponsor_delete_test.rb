require 'test_helper'

class SponsorDeleteTest < ActionDispatch::IntegrationTest
  def check_no_delete_button
    visit sponsor_path(@sponsor1)
    assert page.has_no_link?('Delete Sponsor', href: sponsor_path(@sponsor1))
  end

  test 'visitor may not delete sponsor' do
    check_no_delete_button
  end

  test 'user may not delete sponsor' do
    login_as(@u1, scope: :user)
    check_no_delete_button
  end

  test 'regular admin may not delete sponsor' do
    login_as(@a4, scope: :admin)
    check_no_delete_button
  end

  test 'super admin gets button to delete sponsor' do
    login_as(@a1, scope: :admin)
    visit sponsor_path(@sponsor1)
    assert page.has_link?('Delete Sponsor', href: sponsor_path(@sponsor1))
  end

  test 'super admin can successfully delete sponsors' do
    login_as(@a1, scope: :admin)
    visit sponsor_path(@sponsor1)

    assert_difference 'Sponsor.count', -1 do
      click_on 'Delete Sponsor'
    end

    assert page.has_link?('Sky Store', href: sponsor_path(@sponsor2))
    assert page.has_link?('Island Hoppers', href: sponsor_path(@sponsor3))
    assert page.has_link?('Foundation for Law and Government', href: sponsor_path(@sponsor4))
  end
end
