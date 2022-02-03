class Task < ApplicationRecord
    validates :name, presence: true
    validates :body, length: { maximum: 240 }
    validates :task_date, presence: true

    belongs_to :category
    belongs_to :user
end
