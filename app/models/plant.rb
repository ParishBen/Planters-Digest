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
 
    def self.search(search)
        if search
            plant_type = Plant.find_by(plant_type: search)
            if plant_type
                self.where(plant_type: plant_type.plant_type)
            else
                @plants = Plant.all
            end
        else
            @plants = Plant.all
        end
    end
end
