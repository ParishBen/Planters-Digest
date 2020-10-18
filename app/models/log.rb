class Log < ApplicationRecord
    belongs_to :plant
    validates :water_date, :condition_update, presence: true
    
end
