class Plant < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :logs
    has_many :users, through: :comments
end
