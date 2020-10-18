class Plant < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :logs, dependent: :destroy
    has_many :commenters, through: :comments
    validates :nickname, :plant_type, presence: true
    accepts_nested_attributes_for :comments
    accepts_nested_attributes_for :logs
    accepts_nested_attributes_for :commenters

    # def comments_attributes=(attributes)
    #     attributes.values.each do |attrs|
    #         attrs[:content]
    #         attrs[:commenter_id] = current_user.id
    #         self.comments.build(attrs)
    #     end
    # end
end
