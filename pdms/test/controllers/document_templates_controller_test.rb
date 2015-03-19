require 'test_helper'

class DocumentTemplatesControllerTest < ActionController::TestCase
  setup do
    @document_template = document_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:document_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_template" do
    assert_difference('DocumentTemplate.count') do
      post :create, document_template: { name: @document_template.name, template: @document_template.template }
    end

    assert_redirected_to document_template_path(assigns(:document_template))
  end

  test "should show document_template" do
    get :show, id: @document_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document_template
    assert_response :success
  end

  test "should update document_template" do
    patch :update, id: @document_template, document_template: { name: @document_template.name, template: @document_template.template }
    assert_redirected_to document_template_path(assigns(:document_template))
  end

  test "should destroy document_template" do
    assert_difference('DocumentTemplate.count', -1) do
      delete :destroy, id: @document_template
    end

    assert_redirected_to document_templates_path
  end
end
