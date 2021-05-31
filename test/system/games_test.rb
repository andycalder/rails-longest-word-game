require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling in invalid word should print error message" do
    visit new_url
    fill_in('word', with: 'asdfghjklqwer')
    click_on('Submit')

    assert test: "Invalid word"
    assert page.has_content?('Sorry')
  end

  test "Filling in a valid word should print congratulations message" do
    visit('/score?word=rich&letters=L+I+S+Z+U+S+R+C+I+H')

    assert test: "Valid word"
    assert page.has_content?('Congratulations')
  end
end
