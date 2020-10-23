class Comment < ApplicationRecord
    belongs_to :plant
    belongs_to :commenter, foreign_key: :commenter_id, class_name: 'User'
    accepts_nested_attributes_for :commenter
    accepts_nested_attributes_for :plant
    validates :content, presence: true
    
end
