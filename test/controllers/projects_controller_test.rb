require 'test_helper'

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
end
