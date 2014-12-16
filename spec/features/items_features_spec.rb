require 'rails_helper'
require 'helpers/users'

describe 'Items' do

  context 'have not been added yet' do

    it 'should display a message saying no items added' do
      visit '/'
      expect(page).to have_content 'No items have been added to the site yet.'
    end

  end

  context 'have been added' do

    before do
      Item.create(name: 'Orlando Guitar', user_id: 1)
    end

    it 'should be displayed on the screen' do
      visit '/'
      expect(page).to have_content 'Orlando Guitar'
    end

  end

  context 'can be added' do
    it 'should require registered user to complete a form' do
      sign_up
      sign_in('pete@hrc.com', 'testtest')
      click_link 'Add a new Item'
      fill_in 'Name', with: 'Orlando Guitar'
      fill_in 'Description', with: '1998 Les Paul. Black.'
      fill_in 'Price', with: 5
      click_button 'Submit Item'

      expect(page).to have_content 'Orlando Guitar'
      expect(current_path).to eq '/'
    end

    it 'only by registered users' do
      visit '/items/new'
      expect(page).to have_content 'You must be registered to list a new pin'
    end

    it 'with a photo' do
      sign_up
      sign_in('pete@hrc.com', 'testtest')
      click_link 'Add a new Item'
      fill_in 'Name', with: 'Orlando Guitar'
      fill_in 'Description', with: '1998 Les Paul. Black.'
      fill_in 'Price', with: 5
      attach_file 'Photo', 'spec/helpers/cow.jpg'
      click_button 'Submit Item'

      expect(page).to have_selector("img[alt='Cgit aow']")
    end

  end

end