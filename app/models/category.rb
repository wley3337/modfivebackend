class Category < ApplicationRecord
    has_many :note_categories
    has_many :notes, through: :note_categories
    
end
