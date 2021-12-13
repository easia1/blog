require 'rails_helper'

describe Category, type: :feature do
    before do
        @user = create(:user)
        sign_in @user
    end

    describe 'Create new category' do
        before { visit root_path }
        it 'should show new category page' do
            within 'body' do
                expect(page).to have_content 'Categories'
                click_on 'New Category'
            end

            expect(page).to have_current_path new_category_path
        end

        

        
    end
end