require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = create(:user)
  end

  let!(:task) {Task.new}
  let(:valid_category) {Category.create(name: 'Sample Category', details: 'Sample details', user_id: @user.id)}
  let(:invalid_category) {Category.create(name: nil, details: 'Sample details', user_id: @user.id)}
  let(:new_task) {Task.create(name: 'Task Name', task_date: Date.today, user_id: @user.id, category_id: valid_category.id)}
  
  describe 'Validations' do
    context 'Task name' do
      it 'should be present' do
        task.name = nil
        task.user_id = @user.id
        task.category_id = valid_category.id
        task.task_date = Date.today

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:name)
      end

      it 'should be unique' do
        new_task
        task.name = 'Task Name'
        task.user_id = @user.id
        task.category_id = valid_category.id
        task.task_date = Date.today

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:name)
      end
    end

    context 'Task date' do
      it 'should be present' do
        task.name = 'Task Name'
        task.user_id = @user.id
        task.category_id = valid_category.id

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:task_date)
      end
    end

    context 'Task body' do
      it 'should not be longer than 240 characters' do
        task.body = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.'
        task.name = 'Sample name'
        task.user_id = @user.id
        task.category_id = valid_category.id
        task.task_date = Date.today

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:body)
      end
    end

    context 'User' do
      it 'should be present' do
        task.name = 'Sample name'
        task.category_id = valid_category.id
        task.task_date = Date.today

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:user)
      end
    end

    context 'Existing category' do
      it 'should be present' do
        task.name = 'Sample name'
        task.task_date = Date.today
        task.user_id = @user.id

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:category)
      end
    end
  end

  describe 'User stories' do
    it '1. As a User, I want to create a task for a specific category so that I can organize tasks quicker' do
      new_task

      expect(Task.count).to eq(1)
      expect(Task.find_by(category_id: valid_category.id)).to eq(new_task)
    end

    it '2. As a User, I want to edit a task to update task\'s details' do
      new_task.update(body: 'Details details')
      expect(Task.find_by(body: 'Details details', category_id: valid_category.id)).to eq(new_task)
    end

    it '3. As A User, I want to view a task to show the task\'s details' do
      expect(new_task).to be_valid
      expect(Task.find_by(name: 'Task Name')).to eq(new_task)
    end

    it '4. As A User, I want to delete a task to lessen my unnecessary daily tasks' do
      expect(new_task).to be_valid
      expect(Task.count).to eq(1)

      new_task.destroy
      expect(Task.count).to eq(0)
    end

  end
end
