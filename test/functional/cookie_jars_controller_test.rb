require 'test_helper'

class CookieJarsControllerTest < ActionController::TestCase
  setup do
    @cookie_jar = cookie_jars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cookie_jars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cookie_jar" do
    assert_difference('CookieJar.count') do
      post :create, cookie_jar: { level: @cookie_jar.level }
    end

    assert_redirected_to cookie_jar_path(assigns(:cookie_jar))
  end

  test "should show cookie_jar" do
    get :show, id: @cookie_jar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cookie_jar
    assert_response :success
  end

  test "should update cookie_jar" do
    put :update, id: @cookie_jar, cookie_jar: { level: @cookie_jar.level }
    assert_redirected_to cookie_jar_path(assigns(:cookie_jar))
  end

  test "should destroy cookie_jar" do
    assert_difference('CookieJar.count', -1) do
      delete :destroy, id: @cookie_jar
    end

    assert_redirected_to cookie_jars_path
  end
end
