class Article < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
    validates :body, presence: true, length: { maximum: 240 }

    has_many :comments
end
