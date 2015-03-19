require 'test_helper'

class DocumentHistoriesControllerTest < ActionController::TestCase
  setup do
    @document_history = document_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:document_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_history" do
    assert_difference('DocumentHistory.count') do
      post :create, document_history: { checksum: @document_history.checksum, uploadedBy: @document_history.uploadedBy, versionNumber: @document_history.versionNumber }
    end

    assert_redirected_to document_history_path(assigns(:document_history))
  end

  test "should show document_history" do
    get :show, id: @document_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document_history
    assert_response :success
  end

  test "should update document_history" do
    patch :update, id: @document_history, document_history: { checksum: @document_history.checksum, uploadedBy: @document_history.uploadedBy, versionNumber: @document_history.versionNumber }
    assert_redirected_to document_history_path(assigns(:document_history))
  end

  test "should destroy document_history" do
    assert_difference('DocumentHistory.count', -1) do
      delete :destroy, id: @document_history
    end

    assert_redirected_to document_histories_path
  end
end
