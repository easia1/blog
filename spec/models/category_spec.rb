require 'rails_helper'

describe Category, type: :model do
    before do
        @user = create(:user)
    end

    let!(:category) {Category.new}
    let(:existing) {Category.create(name: 'Sample Category', details: 'Sample details', user_id: @user.id)}
    let(:task) {Task.create(name: 'Task Name', task_date: Date.today, user_id: @user.id, category_id: category.id)}

    describe 'Validations' do
        context 'Category name' do
            it 'should be present' do
                category.details = 'Sample details'
                category.name = nil
                category.user_id = @user.id

                expect(category).to_not be_valid
                expect(category.errors).to be_present
                expect(category.errors.to_hash.keys).to include(:name)
            end

            it 'should be unique' do
                existing
                category.name = 'Sample Category'
                category.user_id = @user.id 

                expect(category).to_not be_valid
                expect(category.errors).to be_present
                expect(category.errors.to_hash.keys).to include(:name)
            end
        end
        context 'Category details' do
            it 'should not be longer than 240 characters' do
                category.details = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.'
                category.name = 'Sample name'
                category.user_id = @user.id

                expect(category).to_not be_valid
                expect(category.errors).to be_present
                expect(category.errors.to_hash.keys).to include(:details)
            end
        end

        context 'User' do
            it 'should be present' do
                category.details = 'Sample details'
                category.name = 'Sample name'

                expect(category).to_not be_valid
                expect(category.errors).to be_present
                expect(category.errors.to_hash.keys).to include(:user)
            end
        end
    end

    describe 'User Stories' do
        it '1. As a User, I want to create a category that can be used to organize my tasks' do
            category_count = Category.count
            category.name = 'Category name'
            category.details = 'details'
            category.user_id = @user.id

            category.save!

            expect(Category.count).to eq(1)
        end

        it '2. As a User, I want to edit a category to update the category\'s details' do
            existing.update(name: 'Ulit ulit', details: 'Details details')
            expect(Category.find_by(name: 'Ulit ulit')).to eq(existing)
        end

        it '3. As A User, I want to view a category to show the category\'s details' do
            expect(existing).to be_valid
            expect(Category.find_by(name: 'Sample Category')).to eq(existing)
        end
    end
end
