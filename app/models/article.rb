class Article < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :body, presence: true, length: { maximum: 240 }
end
