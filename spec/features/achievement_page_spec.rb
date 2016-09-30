require 'rails_helper'

feature 'achievement page' do

  scenario 'achievement public page' do
    # achievement = Achievement.create(title: 'Just did it')
    # achievements = FactoryGirl.create_list(:achievement, 3)
    achievement = FactoryGirl.create(:achievement, title: 'Just did it')
    visit("/achievements/#{achievement.id}")
    expect(page).to have_content('Just did it')
  end

  scenario 'render markdown description' do
    achievement = FactoryGirl.create(:achievement, description: "That *was* hard")
    visit("/achievements/#{achievement.id}")
    expect(page).to have_css('em', text: 'was')
  end
end
