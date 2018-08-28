class Note < ApplicationRecord
    belongs_to :user
    has_many :note_categories
    has_many :categories, through: :note_categories
    accepts_nested_attributes_for :categories
    
    # limits the kind of notes category associations return with json
    def self.public?
        self.all.select{ |note| note.public == true}
    end

    def self.mine?
        self.all.select { |note| note.user_id == current_user.id}
    end 
end
