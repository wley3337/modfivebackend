class Catagory < ApplicationRecord
    has_many :note_catagories
    has_many :notes, through: :note_catagories
    
end
