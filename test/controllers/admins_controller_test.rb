# rubocop:disable Metrics/ClassLength
require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  # BEGIN: SHOW
  # BEGIN: show-public
  test 'should redirect profile page when not logged in' do
    get admin_path(@a1)
    assert_redirected_to root_path
    get admin_path(@a2)
    assert_redirected_to root_path
    get admin_path(@a3)
    assert_redirected_to root_path
    get admin_path(@a4)
    assert_redirected_to root_path
    get admin_path(@a5)
    assert_redirected_to root_path
    get admin_path(@a6)
    assert_redirected_to root_path
  end
  # END: show-public

  # BEGIN: show-user
  test 'should redirect users from profile page' do
    sign_in @u1, scope: :user
    get admin_path(@a1)
    assert_redirected_to root_path
    get admin_path(@a2)
    assert_redirected_to root_path
    get admin_path(@a3)
    assert_redirected_to root_path
    get admin_path(@a4)
    assert_redirected_to root_path
    get admin_path(@a5)
    assert_redirected_to root_path
    get admin_path(@a6)
    assert_redirected_to root_path
  end
  # END: show-user

  # BEGIN: show-regular_admin
  test 'should not redirect profile page when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    get admin_path(@a1)
    assert_response :success
    get admin_path(@a2)
    assert_response :success
    get admin_path(@a3)
    assert_response :success
    get admin_path(@a4)
    assert_response :success
    get admin_path(@a5)
    assert_response :success
    get admin_path(@a6)
    assert_response :success
  end
  # END: show-regular_admin

  # BEGIN: show-super_admin
  test 'should not redirect profile page when logged in as a super admin' do
    sign_in @a1, scope: :admin
    get admin_path(@a1)
    assert_response :success
    get admin_path(@a2)
    assert_response :success
    get admin_path(@a3)
    assert_response :success
    get admin_path(@a4)
    assert_response :success
    get admin_path(@a5)
    assert_response :success
    get admin_path(@a6)
    assert_response :success
  end
  # END: show-super_admin
  # END: SHOW

  # BEGIN: INDEX
  # BEGIN: index-public
  test 'should redirect index page when not logged in' do
    get admins_path
    assert_redirected_to root_path
  end
  # END: index-public

  # BEGIN: index-user
  test 'should redirect index page when logged in as a user' do
    sign_in @u1, scope: :user
    get admins_path
    assert_redirected_to root_path
  end
  # END: index-user

  # BEGIN: index-regular_admin
  test 'should not redirect index page when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    get admins_path
    assert_response :success
  end
  # END: index-regular_admin

  # BEGIN: index-super_admin
  test 'should not redirect index page when logged in as a super admin' do
    sign_in @a1, scope: :admin
    get admins_path
    assert_response :success
  end
  # END: index-super_admin
  # END: INDEX

  # BEGIN: DELETE
  # BEGIN: delete-public
  test 'should not allow visitor to delete admin' do
    assert_no_difference 'Admin.count' do
      delete admin_path(@a5)
      assert_redirected_to root_path
      delete admin_path(@a6)
      assert_redirected_to root_path
    end
  end
  # END: delete-public

  # BEGIN: delete-user
  test 'should not allow user to delete admin' do
    assert_no_difference 'Admin.count' do
      sign_in @u1, scope: :user
      delete admin_path(@a5)
      assert_redirected_to root_path
      delete admin_path(@a6)
      assert_redirected_to root_path
    end
  end
  # END: delete-user

  # BEGIN: delete-self-regular
  # NOTE: regular admin can delete self through edit registration form
  test 'should not allow regular admin to delete self' do
    assert_no_difference 'Admin.count' do
      sign_in @a6, scope: :admin
      delete admin_path(@a6)
      assert_redirected_to root_path
    end
  end
  # END: delete-self-regular

  # BEGIN: delete-self-super
  # NOTE: super admin can delete self through edit registration form
  test 'should not allow super admin to delete self' do
    assert_no_difference 'Admin.count' do
      sign_in @a5, scope: :admin
      delete admin_path(@a5)
      assert_redirected_to root_path
    end
  end
  # END: delete-self-super

  # BEGIN: delete-regular-regular
  test 'should not allow regular admin to delete another regular admin' do
    assert_no_difference 'Admin.count' do
      sign_in @a4, scope: :admin
      delete admin_path(@a6)
      assert_redirected_to root_path
    end
  end
  # END: delete-regular-regular

  # BEGIN: delete-regular-super
  test 'should not allow regular admin to delete super admin' do
    assert_no_difference 'Admin.count' do
      sign_in @a6, scope: :admin
      delete admin_path(@a5)
      assert_redirected_to root_path
    end
  end
  # END: delete-regular-super

  # BEGIN: delete-super-super
  test 'should not allow super admin to delete another super admin' do
    assert_no_difference 'Admin.count' do
      sign_in @a1, scope: :admin
      delete admin_path(@a5)
      assert_redirected_to root_path
    end
  end
  # END: delete-super-super

  # BEGIN: delete-super-regular
  test 'should allow super admin to delete regular admin' do
    assert_difference 'Admin.count', -1 do
      sign_in @a5, scope: :admin
      delete admin_path(@a6)
      assert_redirected_to admins_path
    end
  end
  # END: delete-super-regular
  # END: DELETE
end
# rubocop:enable Metrics/ClassLength
