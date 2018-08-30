class CategoriesController < ApplicationController
    def index
        render json: Category.all.map{ |cat| cat.serialize}
    end 
end