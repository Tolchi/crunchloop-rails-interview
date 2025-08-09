require "rails_helper"

describe "Todo creation", js: true do
  let!(:todo_list) { create(:todo_list) }
  it "creates a new todo and it attached it todo list show page" do
    visit "/todolists/#{todo_list.id}"

    fill_in "Todo description", with: "New todo description"
    click_button "Create todo"

    expect(page).to have_content("New todo description")
  end
end
