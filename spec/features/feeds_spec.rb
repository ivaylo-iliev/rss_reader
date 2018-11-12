require 'rails_helper'
# require 'feed/feed'

feature "Visit feeds" do
  scenario "able to open the list of feeds", js: true do
    visit("/")
    expect(page).to have_content ("Wellcome to your aggregated feed")
  end
end

feature "Add new feed" do
  scenario "able to create new feed", js: false do
    visit("/feeds/new")
    fill_in 'Name', with: "CNN"
    fill_in 'Url', with: "http://rss.cnn.com/rss/cnn_topstories.rss"
    fill_in 'Description', with: "CNN"
    click_button 'Save'
    expect(page).to have_content("Feed was successfully created.")
  end
end

feature "Reload all feeds" do
  scenario "all feeds reloaded on demand", js: true do
    visit("/feeds?reload_all=true")
    expect(page).to have_content("All feeds were successfully updated.")
  end
end

