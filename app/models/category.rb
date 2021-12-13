class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: { scope: :user_id }
    validates :details, length: { maximum: 240 }

    has_many :tasks, dependent: :destroy # so that all dependents will be destroyed along with the parent
    belongs_to :user
end
