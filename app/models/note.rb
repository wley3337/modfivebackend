class Note < ApplicationRecord
    belongs_to :user
    has_many :note_catagories
    has_many :catagories, through: :note_catagories
    accepts_nested_attributes_for :catagories
    
    # limits the kind of notes catagory associations return with json
    def self.public?
        self.all.select{ |note| note.public == true}
    end

    def self.mine?
        self.all.select { |note| note.user_id == current_user.id}
    end 
end
