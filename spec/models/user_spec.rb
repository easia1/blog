require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  let(:category) {Category.create(name: 'Sample Category', details: 'Sample details', user_id: @user.id)}
  let(:task) {Task.create(name: 'Task Name', task_date: Date.today, user_id: @user.id, category_id: category.id)}

  describe 'Dependencies' do
    context 'Categories' do
      it 'should be deleted if User is deleted' do
        category
        expect(Category.where(user_id: @user.id).count).to eq(1)
        @user.destroy

        expect(Category.where(user_id: @user.id).count).to eq(0)
      end
    end

    context 'Tasks' do
      it 'should be deleted if User is deleted' do
        category
        task
        expect(Task.where(user_id: @user.id).count).to eq(1)
        @user.destroy

        expect(Task.where(user_id: @user.id).count).to eq(0)
      end
    end
  end

end
