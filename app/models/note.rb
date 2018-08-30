class Note < ApplicationRecord
    belongs_to :user
    has_many :note_categories
    has_many :categories, through: :note_categories
    accepts_nested_attributes_for :categories
    
    # limits the kind of notes category associations return with json

   
    def self.public?
        self.all.select{ |note| note.public_note == true}
    end

    def self.mine?
        self.all.select { |note| note.user_id == current_user.id}
    end 

    def self.creation(user, content, category_ids, public_note)
    
        new_note = Note.create(user_id: user.id, note_content: content, public_note: public_note )
        category_ids.each{ |id| new_note.categories << Category.find(id)} 
        new_note.save
        new_note
    end 
end
