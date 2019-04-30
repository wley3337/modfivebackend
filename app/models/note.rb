class Note < ApplicationRecord
    belongs_to :user
    has_many :note_categories
    has_many :categories, through: :note_categories
    accepts_nested_attributes_for :categories
    
    # limits the kind of notes category associations return with json

   
    def self.public?
        self.all.select{ |note| note.public_note === true}
    end

    # def self.mine?
    #     self.all.select { |note| note.user_id == current_user.id}
    # end 
    def add_categories(category_ids_array)
        category_ids_array.each{ |id| self.categories << Category.find(id)} 
        self
    end

    def self.creation(user, content, category_ids, public_note)
        new_note = Note.create(user_id: user.id, note_content: content, public_note: public_note )
        new_note.add_categories(category_ids)
        new_note.save
        new_note
    end 

    def serialize_note
        {note: self, categories: self.categories.map{|category| {id: category.id, name: category.name}}}
    end

    def update_note(content, category_ids, public_note)
        NoteCategory.where(note_id: self.id).delete_all
        self.note_content = content
        self.public_note = public_note
        category_ids.each {|cat_id| self.categories << Category.find(cat_id)}
        self.save
        self
    end

    def self.public_note_set(starting_id)
        self.where("public_note = ? AND id > ?", true, starting_id).limit(50).map{|note| note.serialize_note}
    end 

    def self.search_public_note_set(starting_id, search_term)
        self.where("public_note = ? AND id > ? AND note_content like ?", true, starting_id, "%#{search_term}%").limit(300).map{|note| note.serialize_note}
    end
end
