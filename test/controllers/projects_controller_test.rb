require 'test_helper'

# rubocop:disable Metrics/ClassLength
class ProjectsControllerTest < ActionDispatch::IntegrationTest
  # BEGIN: definitions
  def create_project
    title1 = 'Fake Blofelds'
    url_s = 'https://github.com/blofeld/fake_blofelds'
    url_d = 'http://www.fakeblofelds.com'
    desc1 = 'Create fake versions of myself to confuse James Bond!'
    post projects_path, params: { project: { title: title1,
                                             source_code_url: url_s,
                                             deployed_url: url_d,
                                             description: desc1 } }
  end

  def create_project_disabled
    assert_no_difference 'Project.count' do
      create_project
    end
    assert_redirected_to root_path
  end

  def edit_project
    title1 = 'For Your Eyes Only'
    desc1 = 'Retrieve ATAC'
    url_s = 'https://github.com/rmoore/fyeo'
    url_d = 'http://www.fyeo1981.com'
    patch project_path(@p2),
          params: { project: { title: title1,
                               description: desc1,
                               source_code_url: url_s,
                               deployed_url: url_d } }
  end

  def edit_project_disabled
    edit_project
    assert_redirected_to root_path
  end

  def delete_project
    delete project_path(@p2)
  end

  def delete_project_disabled
    assert_no_difference 'Project.count' do
      delete_project
      assert_redirected_to root_path
    end
  end
  # END: definitions

  test 'project show action' do
    get project_path(@p1)
    assert_response :success
    get project_path(@p2)
    assert_response :success
    get project_path(@p3)
    assert_response :success
    get project_path(@p4)
    assert_response :success
    get project_path(@p5)
    assert_response :success
  end

  test 'project index action' do
    get projects_path
    assert_response :success
  end

  test 'should redirect create when not logged in' do
    create_project_disabled
  end

  test 'should not redirect user' do
    sign_in @u7, scope: :user
    assert_difference 'Project.count', 1 do
      create_project
    end
    assert_redirected_to user_path(@u7)
  end

  test 'should redirect create for regular admin' do
    sign_in @a4, scope: :admin
    create_project_disabled
  end

  test 'should redirect create for super admin' do
    sign_in @a1, scope: :admin
    create_project_disabled
  end

  test 'should redirect edit to root when not logged in' do
    edit_project_disabled
  end

  # rubocop:disable Metrics/LineLength
  test 'should not redirect edit to root when logged in as the user with the project' do
    sign_in @u3, scope: :user
    edit_project
    assert_redirected_to project_path(@p2)
  end
  # rubocop:enable Metrics/LineLength

  test 'should redirect edit to root when logged in as a different user' do
    sign_in @u2, scope: :user
    edit_project_disabled
  end

  test 'should redirect edit to root when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    edit_project_disabled
  end

  test 'should redirect edit to root when logged in as a super admin' do
    sign_in @a1, scope: :admin
    edit_project_disabled
  end

  test 'should redirect delete when not logged in' do
    delete_project_disabled
  end

  test 'should redirect delete when logged in as the wrong user' do
    sign_in @u1, scope: :user
    delete_project_disabled
  end

  test 'should not redirect delete when logged in as the right user' do
    sign_in @u3, scope: :user
    assert_difference 'Project.count', -1 do
      delete_project
      assert_redirected_to user_path(@u3)
    end
  end

  test 'should not redirect delete when logged in as a regular admin' do
    sign_in @a4, scope: :admin
    assert_difference 'Project.count', -1 do
      delete_project
      assert_redirected_to user_path(@u3)
    end
  end

  test 'should not redirect delete when logged in as a super admin' do
    sign_in @a1, scope: :admin
    assert_difference 'Project.count', -1 do
      delete_project
      assert_redirected_to user_path(@u3)
    end
  end
end
# rubocop:enable Metrics/ClassLength
