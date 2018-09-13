class NotesController < ApplicationController
    
    def index
        # return sets of 300 from last index bulk  
        public_note_set = Note.public_note_set(params["offsetId"])

        if public_note_set.length < 50
         render json:  {notes: public_note_set, more: false}
        else
         render json:  {notes: public_note_set, more: true}
        end 
    end


    def search_index
      
        searched_public_note_set = Note.search_public_note_set(params["offsetId"], params["searchTerm"])

        if searched_public_note_set.length < 50
            render json:  { notes: searched_public_note_set, more: false }
        else
            render json:  { notes: searched_public_note_set, more: true }
        end 
    end

    def destroy
        #local strong params
        note_params = params.require(:note).permit(:id)
        user = current_user
        note = Note.find(note_params["id"])
        if current_user.id === note.user_id   
            note.delete
        end 
        render json:  {success: true,  userObj: current_user.serialize_user}
    end 

    

end
