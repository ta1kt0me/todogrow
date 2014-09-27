require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should get closed_index" do
    get :closed_index
    assert_response :success
  end

end
