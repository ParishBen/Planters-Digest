class Plant < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :logs, dependent: :destroy
    has_many :commenters, through: :comments
    validates :nickname, :plant_type, presence: true
    

    scope :popular, -> {Plant.left_joins(:comments).group('plants.id').order('count(comments.plant_id) desc')}
    scope :search, -> (query) {where("plant_type LIKE ?", "%#{query}%")}


    # def self.search(query)
    #     if query.present?
    #         where('PLANT_TYPE like ?', "%#{query}%")
    #     else
    #         @plants = Plant.all
    #     end
    # end
end
