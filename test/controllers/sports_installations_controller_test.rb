require 'test_helper'

class SportsInstallationsControllerTest < ActionController::TestCase
  setup do
    @sports_installation = sports_installations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sports_installations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sports_installation" do
    assert_difference('SportsInstallation.count') do
      post :create, sports_installation: { installation_id: @sports_installation.installation_id, sport_id: @sports_installation.sport_id }
    end

    assert_redirected_to sports_installation_path(assigns(:sports_installation))
  end

  test "should show sports_installation" do
    get :show, id: @sports_installation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sports_installation
    assert_response :success
  end

  test "should update sports_installation" do
    patch :update, id: @sports_installation, sports_installation: { installation_id: @sports_installation.installation_id, sport_id: @sports_installation.sport_id }
    assert_redirected_to sports_installation_path(assigns(:sports_installation))
  end

  test "should destroy sports_installation" do
    assert_difference('SportsInstallation.count', -1) do
      delete :destroy, id: @sports_installation
    end

    assert_redirected_to sports_installations_path
  end
end
