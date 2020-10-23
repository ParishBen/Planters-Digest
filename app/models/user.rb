class User < ApplicationRecord
    has_many :plants, dependent: :destroy
    has_many :logs, through: :plants
    has_many :comments, foreign_key: :commenter_id
    has_many :commented_plants, through: :comments, source: :plant
    has_secure_password
    #has_many :tips
    validates :username, :password, :password_confirmation, :email, presence: true
    validates :password, confirmation: true
    
    
    

end
