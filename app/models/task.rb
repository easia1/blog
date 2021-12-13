class Task < ApplicationRecord
    validates :name, presence: true, uniqueness: { scope: [:user_id, :category_id]}
    validates :body, length: { maximum: 240 }
    validates :task_date, presence: true

    belongs_to :category
    belongs_to :user
end
