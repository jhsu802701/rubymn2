require 'test_helper'

class SponsorsControllerTest < ActionDispatch::IntegrationTest
  # BEGIN: definitions
  def create_sponsor
    post sponsors_path, params: { sponsor: { name: 'Pear Computer' } }
  end

  def create_sponsor_disabled
    assert_no_difference 'Sponsor.count' do
      create_sponsor
    end
    assert_redirected_to root_path
  end

  def edit_sponsor
    patch sponsor_path(@sponsor1),
          params: { sponsor: { description: 'parody of Best Buy' } }
  end

  def edit_sponsor_disabled
    edit_sponsor
    assert_redirected_to root_path
  end

  def delete_sponsor
    delete sponsor_path(@sponsor1)
  end

  def delete_sponsor_disabled
    assert_no_difference 'Admin.count' do
      delete_sponsor
      assert_redirected_to root_path
    end
  end
  # END: definitions

  test 'sponsor show action' do
    get sponsor_path(@sponsor1)
    assert_response :success
    get sponsor_path(@sponsor2)
    assert_response :success
    get sponsor_path(@sponsor3)
    assert_response :success
    get sponsor_path(@sponsor4)
    assert_response :success
  end

  test 'sponsor index action' do
    get sponsors_path
    assert_response :success
  end

  test 'should redirect create when not logged in' do
    create_sponsor_disabled
  end

  test 'should redirect create when logged in as a user' do
    sign_in @u1, scope: :user
    create_sponsor_disabled
  end

  test 'should redirect create when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    create_sponsor_disabled
  end

  test 'should not redirect create when logged in as a super admin' do
    sign_in @a1, scope: :admin
    assert_difference 'Sponsor.count', 1 do
      create_sponsor
    end
  end

  test 'should redirect edit to root when not logged in' do
    edit_sponsor_disabled
  end

  test 'should redirect edit to root when logged in as a user' do
    sign_in @u1, scope: :user
    edit_sponsor_disabled
  end

  test 'should redirect edit to root when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    edit_sponsor_disabled
  end

  test 'should redirect edit to show when logged in as a super admin' do
    sign_in @a1, scope: :admin
    edit_sponsor
    assert_redirected_to sponsor_path(@sponsor1)
  end

  test 'should redirect delete when not logged in' do
    delete_sponsor_disabled
  end

  test 'should redirect delete when logged in as a user' do
    sign_in @u1, scope: :user
    delete_sponsor_disabled
  end

  test 'should redirect delete when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    delete_sponsor_disabled
  end

  test 'should not redirect delete when logged in as a super admin' do
    sign_in @a1, scope: :admin
    assert_difference 'Sponsor.count', -1 do
      delete_sponsor
    end
  end
end
