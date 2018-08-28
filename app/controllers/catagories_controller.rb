class CatagoriesController < ApplicationController
    def index
        render json: Catagory.all
    end 
end