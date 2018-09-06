class ReferencesController < ApplicationController

    def index
        response json: Reference.all.map{|ref| ref.serialize}
    end
    
    def create
        # validate for url uniquness return existing title
        # add a save to my references?
    end

    def save
        # saves a reference to a users own reference
    end

    def remove
        # removes a reference from current users references.
    end 

end
