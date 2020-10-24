class User < ApplicationRecord
    has_many :plants, dependent: :destroy
    has_many :logs, through: :plants
    has_many :comments, foreign_key: :commenter_id
    has_many :commented_plants, through: :comments, source: :plant
    has_secure_password
    #has_many :tips
    validates :username, :password, :email, presence: true
    validates :username, uniqueness: true
    
    scope :most_plants, -> {User.left_joins(:plants).group('users.id').order('count(plants.user_id) desc')}
    

end
