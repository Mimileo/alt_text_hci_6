require "application_system_test_case"

class AltFavoritesTest < ApplicationSystemTestCase
  setup do
    @alt_favorite = alt_favorites(:one)
  end

  test "visiting the index" do
    visit alt_favorites_url
    assert_selector "h1", text: "Alt favorites"
  end

  test "should create alt favorite" do
    visit alt_favorites_url
    click_on "New alt favorite"

    fill_in "Alt", with: @alt_favorite.alt_id
    fill_in "Integer", with: @alt_favorite.integer
    fill_in "Integer,", with: @alt_favorite.integer,
    fill_in "User", with: @alt_favorite.user_id
    click_on "Create Alt favorite"

    assert_text "Alt favorite was successfully created"
    click_on "Back"
  end

  test "should update Alt favorite" do
    visit alt_favorite_url(@alt_favorite)
    click_on "Edit this alt favorite", match: :first

    fill_in "Alt", with: @alt_favorite.alt_id
    fill_in "Integer", with: @alt_favorite.integer
    fill_in "Integer,", with: @alt_favorite.integer,
    fill_in "User", with: @alt_favorite.user_id
    click_on "Update Alt favorite"

    assert_text "Alt favorite was successfully updated"
    click_on "Back"
  end

  test "should destroy Alt favorite" do
    visit alt_favorite_url(@alt_favorite)
    click_on "Destroy this alt favorite", match: :first

    assert_text "Alt favorite was successfully destroyed"
  end
end
