require 'rails_helper'

describe Category, type: :model do
    let!(:category) {Category.new}

    let(:existing) {Category.create(name: 'Sample Category', details: 'Sample details')}
    
    context 'Validations' do
        it '1. Is not valid without a name' do
            category.details = 'Sample details'
            category.name = nil

            expect(category).to_not be_valid
            expect(category.errors).to be_present
            expect(category.errors.to_hash.keys).to include(:name)
        end

        it '2. As a User, I want to create a category that can be used to organize my tasks' do
            category_count = Category.count
            category.name = 'Category name'
            category.details = 'details'

            category.save!

            expect(Category.count).to eq(1)
        end

        it '3. As a User, I want to edit a category to update the category\'s details' do
            existing.update(name: 'Ulit ulit', details: 'Details details')
            expect(Category.find_by(name: 'Ulit ulit')).to eq(existing)
        end

        it '4. As A User, I want to view a category to show the category\'s details' do
            expect(existing).to be_valid
            expect(Category.find_by(name: 'Sample Category')).to eq(existing)
        end
    end
end
