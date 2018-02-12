require 'test_helper'

# rubocop:disable Metrics/ClassLength
class ForhiresControllerTest < ActionDispatch::IntegrationTest
  # BEGIN: definitions
  def create_forhire
    title1 = 'Master Villain'
    email1 = 'ernst_stavro_blofeld@example.com'
    desc1 = 'I am out to take over the world!'
    post forhires_path, params: { forhire: { title: title1,
                                             email: email1,
                                             description: desc1 } }
  end

  def create_forhire_disabled
    assert_no_difference 'Forhire.count' do
      create_forhire
    end
    assert_redirected_to root_path
  end

  def edit_forhire
    patch forhire_path(@fh_connery),
          params: { forhire: { description: 'I stopped Largo twice!',
                               email: 'bond1983@rubyonracetracks.com',
                               title: 'James Bond 1983' } }
  end

  def edit_forhire_disabled
    edit_forhire
    assert_redirected_to root_path
  end

  def delete_forhire
    delete forhire_path(@fh_lazenby)
  end

  def delete_forhire_disabled
    assert_no_difference 'Forhire.count' do
      delete_forhire
      assert_redirected_to root_path
    end
  end
  # END: definitions

  test 'forhire show action' do
    get forhire_path(@fh_connery)
    assert_response :success
    get forhire_path(@fh_lazenby)
    assert_response :success
    get forhire_path(@fh_moore)
    assert_response :success
    get forhire_path(@fh_dalton)
    assert_response :success
    get forhire_path(@fh_brosnan)
    assert_response :success
    get forhire_path(@fh_craig)
    assert_response :success
  end

  test 'forhire index action' do
    get forhires_path
    assert_response :success
  end

  test 'should redirect create when not logged in' do
    create_forhire_disabled
  end

  test 'should redirect create for user who already has a forhire profile' do
    sign_in @u1, scope: :user
    create_forhire_disabled
  end

  test 'should not redirect user without an existing forhire profile' do
    sign_in @u7, scope: :user
    assert_difference 'Forhire.count', 1 do
      create_forhire
    end
    assert_redirected_to user_path(@u7)
  end

  test 'should redirect create for regular admin' do
    sign_in @a4, scope: :admin
    create_forhire_disabled
  end

  test 'should redirect create for super admin' do
    sign_in @a1, scope: :admin
    create_forhire_disabled
  end

  test 'should redirect edit to root when not logged in' do
    edit_forhire_disabled
  end

  # rubocop:disable Metrics/LineLength
  test 'should not redirect edit to root when logged in as the user with the forhire' do
    sign_in @u1, scope: :user
    edit_forhire
    assert_redirected_to forhire_path(@fh_connery)
  end
  # rubocop:enable Metrics/LineLength

  test 'should redirect edit to root when logged in as a different user' do
    sign_in @u2, scope: :user
    edit_forhire_disabled
  end

  test 'should redirect edit to root when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    edit_forhire_disabled
  end

  test 'should redirect edit to root when logged in as a super admin' do
    sign_in @a1, scope: :admin
    edit_forhire_disabled
  end

  test 'should redirect delete when not logged in' do
    delete_forhire_disabled
  end

  test 'should redirect delete when logged in as the wrong user' do
    sign_in @u1, scope: :user
    delete_forhire_disabled
  end

  test 'should not redirect delete when logged in as the right user' do
    sign_in @u2, scope: :user
    assert_difference 'Forhire.count', -1 do
      delete_forhire
      assert_redirected_to user_path(@u2)
    end
  end

  test 'should not redirect delete when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    assert_difference 'Forhire.count', -1 do
      delete_forhire
      assert_redirected_to user_path(@u2)
    end
  end

  test 'should not redirect delete when logged in as a super admin' do
    sign_in @a1, scope: :admin
    assert_difference 'Forhire.count', -1 do
      delete_forhire
      assert_redirected_to user_path(@u2)
    end
  end
end
# rubocop:enable Metrics/ClassLength
