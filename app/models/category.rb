class Category < ApplicationRecord
    has_many :note_categories
    has_many :notes, through: :note_categories
    has_many :reference_categories
    has_many :references, through: :reference_categories
   
    def serialize
        {id: self.id, name: self.name}
        # removed: notes: self.category_notes don't seem to need
    end

    def category_notes
        self.notes.select{ |note| note.public_note === true}
    end
    
end
