class NotesController < ApplicationController

    def index
         render json:  Note.public?.map{|note| note.serialize_note}
    end

    def update
    end 

end
