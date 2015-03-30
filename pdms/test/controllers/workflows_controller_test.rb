require 'test_helper'

class WorkflowsControllerTest < ActionController::TestCase
  test "should get set" do
    get :set
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
