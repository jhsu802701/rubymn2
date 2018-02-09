require 'test_helper'

class ForhiresControllerTest < ActionDispatch::IntegrationTest
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
end
