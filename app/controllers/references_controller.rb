class ReferencesController < ApplicationController

    def index
        response json: Reference.all.map{|ref| ref.serialize}
    end 
end
