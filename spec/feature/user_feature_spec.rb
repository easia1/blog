require 'rails_helper'

RSpec.describe 'User handling', type: :feature do

    describe 'Signup' do
        before { visit root_path }
        
        it 'should show sign up page after clicking sign up' do
            within 'body' do
                expect(page).to have_content 'Sign up'

                click_on 'Sign up'
            end
            expect(page).to have_current_path '/users/sign_up'
        end

        context 'with valid sign up credentials' do
            before { visit '/users/sign_up' }

            it 'should show categories page' do
                within 'form' do
                    fill_in 'user_email', with: 'test222@test.com'
                    fill_in 'user_password', with: 'test123'
                    fill_in 'user_password_confirmation', with: 'test123'
                    click_on 'Sign up'
                end
                expect(page).to have_content 'Categories'
                expect(page).to have_content 'Welcome! You have signed up successfully.'
            end
        end

        context 'existing email' do
            before { visit '/users/sign_up' }

            it 'should show an error' do
                within 'form' do
                    fill_in 'user_email', with: 'test@test.com'
                    fill_in 'user_password', with: 'test123'
                    fill_in 'user_password_confirmation', with: 'test123'
                    click_on 'Sign up'
                end
                expect(page).to have_content 'Email has already been taken'
            end
        end

        context 'password length less than 6 characters' do
            before { visit '/users/sign_up' }

            it 'should show an error' do
                within 'form' do
                    fill_in 'user_email', with: 'test333@test.com'
                    fill_in 'user_password', with: 't23'
                    fill_in 'user_password_confirmation', with: 't23'
                    click_on 'Sign up'
                end
                expect(page).to have_content 'Password is too short (minimum is 6 characters)'
            end
        end

        context 'password and password confirmation don\t match' do
            before { visit '/users/sign_up' }

            it 'should show an error' do
                within 'form' do
                    fill_in 'user_email', with: 'test333@test.com'
                    fill_in 'user_password', with: 't2sdsd3'
                    fill_in 'user_password_confirmation', with: 't23'
                    click_on 'Sign up'
                end
                expect(page).to have_content 'Password confirmation doesn\'t match Password'
            end
        end

    end
    
    
    
    describe 'Login' do
        before { visit root_path }

        it 'should show log in page' do
            within 'body' do
                expect(page).to have_content 'Log in'
            end
        end

        

        context 'with valid log in credentials' do
            before { visit root_path }

            it 'should show categories page' do
                within 'form' do
                    fill_in 'user_email', with: 'test@test.com'
                    fill_in 'user_password', with: 'test123'
                    click_on 'Log in'
                end
                expect(page).to have_content 'Categories'
            end
        end

        context 'with invalid log in credentials' do
            before { visit root_path }

            it 'should stay in the log in page' do
                within 'form' do
                    fill_in 'user_email', with: 'nganga@imbento.com'
                    fill_in 'user_password', with: 'test123'
                    click_on 'Log in'
                end
                expect(page).to have_current_path '/users/sign_in'
            end
        end
    end
end