require "test_helper"

class AltFavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alt_favorite = alt_favorites(:one)
  end

  test "should get index" do
    get alt_favorites_url
    assert_response :success
  end

  test "should get new" do
    get new_alt_favorite_url
    assert_response :success
  end

  test "should create alt_favorite" do
    assert_difference("AltFavorite.count") do
      post alt_favorites_url, params: { alt_favorite: { alt_id: @alt_favorite.alt_id, integer: @alt_favorite.integer, integer,: @alt_favorite.integer,, user_id: @alt_favorite.user_id } }
    end

    assert_redirected_to alt_favorite_url(AltFavorite.last)
  end

  test "should show alt_favorite" do
    get alt_favorite_url(@alt_favorite)
    assert_response :success
  end

  test "should get edit" do
    get edit_alt_favorite_url(@alt_favorite)
    assert_response :success
  end

  test "should update alt_favorite" do
    patch alt_favorite_url(@alt_favorite), params: { alt_favorite: { alt_id: @alt_favorite.alt_id, integer: @alt_favorite.integer, integer,: @alt_favorite.integer,, user_id: @alt_favorite.user_id } }
    assert_redirected_to alt_favorite_url(@alt_favorite)
  end

  test "should destroy alt_favorite" do
    assert_difference("AltFavorite.count", -1) do
      delete alt_favorite_url(@alt_favorite)
    end

    assert_redirected_to alt_favorites_url
  end
end
