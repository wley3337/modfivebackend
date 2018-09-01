class NotesController < ApplicationController

    def index
         render json:  Note.public?.map{|note| note.serialize_note}
    end

    def destroy
        #local strong params
        note_params = params.require(:note).permit(:id)
        user = current_user
        note = Note.find(note_params["id"])
        if current_user.id === note.user_id
            
            note.delete
        end 
        render json: current_user.serialize_user
    end 

end
