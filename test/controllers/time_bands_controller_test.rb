require 'test_helper'

class TimeBandsControllerTest < ActionController::TestCase
  setup do
    @time_band = time_bands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_bands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_band" do
    assert_difference('TimeBand.count') do
      post :create, time_band: { date: @time_band.date }
    end

    assert_redirected_to time_band_path(assigns(:time_band))
  end

  test "should show time_band" do
    get :show, id: @time_band
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_band
    assert_response :success
  end

  test "should update time_band" do
    patch :update, id: @time_band, time_band: { date: @time_band.date }
    assert_redirected_to time_band_path(assigns(:time_band))
  end

  test "should destroy time_band" do
    assert_difference('TimeBand.count', -1) do
      delete :destroy, id: @time_band
    end

    assert_redirected_to time_bands_path
  end
end
