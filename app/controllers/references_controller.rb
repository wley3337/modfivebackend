class ReferencesController < ApplicationController
    before_action :mod_params, only: [:save, :remove]
    

    def index
      
    
        reference_set = Reference.reference_set(params["offsetId"])
        
        if  reference_set.length < 300
            render json:  {references: reference_set, more: false}
        else
            render json:  {references: reference_set, more: true}
        end 
    end

    def search

        render json: {references: Reference.references_by_category(params["categoryId"])}
    
    end
    
    def create
    debugger
        local_str_params = params.require(:reference).permit(:title, :link)
        # validate for url uniquness return existing title
        new_reference = Reference.new(local_str_params)
        # validate for url uniquness return existing title
       if new_reference.valid?
        new_reference.save
        render json: {success: true, references: Reference.reference_set(0)}  
       else
    debugger
        render json: {success: false, errors: new_reference.errors.messages }
       end
    end

    def save
    debugger
         # saves a reference to a users own reference
        reference_to_save = Reference.find(mod_params["id"])
        reference_to_save.saves = reference_to_save.saves + 1
        current_user.references << reference_to_save
        render json: {success: true,  userObj: current_user.serialize_user}
    end

    def remove
    debugger
        # removes a reference from current users references.
        ref_to_remove = Reference.find(mod_params["id"])
        ref_to_remove.saves = reference_to_save.saves - 1
        current_user.delete(ref_to_remove)
        render json: {success: true,  userObj: current_user.serialize_user}
    end 

    private

    def mod_params
        params.require(:reference).permit(:id)
    end 
end
