class Category < ApplicationRecord
    has_many :note_categories
    has_many :notes, through: :note_categories


    def serialize
        {id: self.id, name: self.name, notes: self.category_notes}
    end

    def category_notes
        self.notes.select{ |note| note.public_note === true}
    end
    
end
