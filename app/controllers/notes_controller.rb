class NotesController < ApplicationController

    def index
        render json: Note.public?
    end

    def update
    end 

end
