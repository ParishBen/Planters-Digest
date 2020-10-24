class Plant < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :logs, dependent: :destroy
    has_many :commenters, through: :comments
    validates :nickname, :plant_type, presence: true
    accepts_nested_attributes_for :comments
    accepts_nested_attributes_for :logs
    accepts_nested_attributes_for :commenters

    scope :popular, -> {Plant.left_joins(:comments).group('plants.id').order('count(comments.plant_id) desc')}
 
end
