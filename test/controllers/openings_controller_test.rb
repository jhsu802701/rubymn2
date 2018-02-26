require 'test_helper'

class OpeningsControllerTest < ActionDispatch::IntegrationTest
  # BEGIN: definitions
  def opening_show_enabled
    get opening_path(@op1)
    assert_response :success
    get opening_path(@op2)
    assert_response :success
    get opening_path(@op3)
    assert_response :success
    get opening_path(@op4)
    assert_response :success
    get opening_path(@op5)
    assert_response :success
  end
  # END: definitions

  test 'unregistered visitor redirected from opening profile page' do
    get opening_path(@op1)
    assert_redirected_to new_user_session_path
    get opening_path(@op2)
    assert_redirected_to new_user_session_path
    get opening_path(@op3)
    assert_redirected_to new_user_session_path
    get opening_path(@op4)
    assert_redirected_to new_user_session_path
    get opening_path(@op5)
    assert_redirected_to new_user_session_path
  end

  test 'user can access opening profile page' do
    sign_in @u7, scope: :user
    opening_show_enabled
  end

  test 'regular admin can access opening profile page' do
    sign_in @a4, scope: :admin
    opening_show_enabled
  end

  test 'super admin can access access opening profile page' do
    sign_in @a1, scope: :admin
    opening_show_enabled
  end
end
