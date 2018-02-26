require 'test_helper'

# rubocop:disable Metrics/ClassLength
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

  def create_opening
    title1 = 'Saboteur'
    desc1 = 'Sabotage the helicopter to be used to pick up James Bond'
    post openings_path, params: { opening: { title: title1,
                                             description: desc1 } }
  end

  def create_opening_disabled
    assert_no_difference 'Opening.count' do
      create_opening
    end
    assert_redirected_to root_path
  end

  def edit_opening
    title1 = 'Deputy of Texarkana'
    desc1 = 'Apprehend those punks while I am busy chasing the Bandit!'
    patch opening_path(@op4),
          params: { opening: { title: title1,
                               description: desc1 } }
  end

  def edit_opening_disabled
    edit_opening
    assert_redirected_to root_path
  end

  def delete_opening
    delete opening_path(@op4)
  end

  def delete_opening_disabled
    assert_no_difference 'Opening.count' do
      delete_opening
      assert_redirected_to root_path
    end
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

  test 'unregistered visitor redirected from opening index page' do
    get openings_path
    assert_redirected_to new_user_session_path
  end

  test 'user can access opening index page' do
    sign_in @u1, scope: :user
    get openings_path
    assert_response :success
  end

  test 'regular admin can access opening index page' do
    sign_in @a4, scope: :admin
    get openings_path
    assert_response :success
  end

  test 'super admin can access opening index page' do
    sign_in @a1, scope: :admin
    get openings_path
    assert_response :success
  end

  test 'should redirect create when not logged in' do
    create_opening_disabled
  end

  test 'should not redirect user' do
    sign_in @u7, scope: :user
    assert_difference 'Opening.count', 1 do
      create_opening
    end
    assert_redirected_to user_path(@u7)
  end

  test 'should redirect create for regular admin' do
    sign_in @a4, scope: :admin
    create_opening_disabled
  end

  test 'should redirect create for super admin' do
    sign_in @a1, scope: :admin
    create_opening_disabled
  end

  test 'should redirect edit to root when not logged in' do
    edit_opening_disabled
  end

  # rubocop:disable Metrics/LineLength
  test 'should not redirect edit to root when logged in as the user with the opening' do
    sign_in @u11, scope: :user
    edit_opening
    assert_redirected_to opening_path(@op4)
  end
  # rubocop:enable Metrics/LineLength

  test 'should redirect edit to root when logged in as a different user' do
    sign_in @u2, scope: :user
    edit_opening_disabled
  end

  test 'should redirect edit to root when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    edit_opening_disabled
  end

  test 'should redirect edit to root when logged in as a super admin' do
    sign_in @a1, scope: :admin
    edit_opening_disabled
  end

  test 'should redirect delete when not logged in' do
    delete_opening_disabled
  end

  test 'should redirect delete when logged in as the wrong user' do
    sign_in @u1, scope: :user
    delete_opening_disabled
  end

  test 'should not redirect delete when logged in as the right user' do
    sign_in @u11, scope: :user
    assert_difference 'Opening.count', -1 do
      delete_opening
      assert_redirected_to user_path(@u11)
    end
  end

  test 'should not redirect delete when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    assert_difference 'Opening.count', -1 do
      delete_opening
      assert_redirected_to user_path(@u11)
    end
  end

  test 'should not redirect delete when logged in as a super admin' do
    sign_in @a1, scope: :admin
    assert_difference 'Opening.count', -1 do
      delete_opening
      assert_redirected_to user_path(@u11)
    end
  end
end
# rubocop:enable Metrics/ClassLength
