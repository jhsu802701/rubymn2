require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
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
end
