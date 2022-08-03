require "application_system_test_case"

class DocumentationsTest < ApplicationSystemTestCase
  setup do
    @documentation = documentations(:one)
  end

  test "visiting the index" do
    visit documentations_url
    assert_selector "h1", text: "Documentations"
  end

  test "should create documentation" do
    visit documentations_url
    click_on "New documentation"

    fill_in "Body", with: @documentation.body
    fill_in "Description", with: @documentation.description
    fill_in "Seo", with: @documentation.seo
    click_on "Create Documentation"

    assert_text "Documentation was successfully created"
    click_on "Back"
  end

  test "should update Documentation" do
    visit documentation_url(@documentation)
    click_on "Edit this documentation", match: :first

    fill_in "Body", with: @documentation.body
    fill_in "Description", with: @documentation.description
    fill_in "Seo", with: @documentation.seo
    click_on "Update Documentation"

    assert_text "Documentation was successfully updated"
    click_on "Back"
  end

  test "should destroy Documentation" do
    visit documentation_url(@documentation)
    click_on "Destroy this documentation", match: :first

    assert_text "Documentation was successfully destroyed"
  end
end
