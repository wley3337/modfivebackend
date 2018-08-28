class Note < ApplicationRecord
    belongs_to :user
    has_many :note_catagories
    has_many :catagories, through: :note_catagories
    
end
