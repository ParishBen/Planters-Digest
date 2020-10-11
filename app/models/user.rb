class User < ApplicationRecord
    has_many :plants
    has_many :logs, through: :plants
    has_many :comments
    has_many :commented_plants, through: :comments, source: :plant
    has_secure_password
end
