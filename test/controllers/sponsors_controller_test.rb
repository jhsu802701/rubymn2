require 'test_helper'

class SponsorsControllerTest < ActionDispatch::IntegrationTest
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
end
