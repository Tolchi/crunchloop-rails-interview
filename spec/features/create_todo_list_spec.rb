require "rails_helper"

describe "Todo list creation" do
  it "succesfully creates todo list", js: true do
    visit "/"
    fill_in "Todo list name", with:"New Todo List Name"
    click_button "Create Todo list"

    expect(page).to have_content("New Todo List Name")
  end
end
