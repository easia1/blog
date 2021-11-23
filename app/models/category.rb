class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :details, length: { maximum: 240 }
end
