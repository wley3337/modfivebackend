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
        local_str_params = params.require(:reference).permit(:title, :link, category: {})

        new_reference = Reference.new({title: local_str_params["title"], link: local_str_params["link"]})
        # validate for url uniquness return existing title
       if new_reference.valid?

        new_reference.save

        new_reference.add_categories(local_str_params["category"]["existingCategory"]) if local_str_params["category"]["existingCategory"].length > 0

        new_reference.add_new_categories(local_str_params["category"]["newCategory"]) if local_str_params["category"]["newCategory"].length > 0
        current_user.references << new_reference
        render json: {success: true, references: Reference.reference_set(0), new_reference: new_reference, userObj: current_user.serialize_user} 

       else
    
        if new_reference.errors.messages[:link] === ["has already been taken"]
            existingReference = Reference.find_by(link: local_str_params["link"])
            current_user.references << existingReference
            render json: {success: true, references: Reference.reference_set(0), userObj: current_user.serialize_user, existingReference: existingReference}
        else
            render json: {success: false, errors: new_reference.errors.messages }
        end
      end
    end

    def save
         # saves a reference to a users own reference
        reference_to_save = Reference.find(mod_params["id"])
        reference_to_save.saves = reference_to_save.saves + 1
        current_user.references << reference_to_save
        render json: {success: true,  userObj: current_user.serialize_user}
    end

    def remove
        # removes a reference from current users references.
        ref_to_remove = Reference.find(mod_params["id"])
        ref_to_remove.saves = ref_to_remove.saves - 1
        current_user.references.delete(ref_to_remove)
        render json: {success: true,  userObj: current_user.serialize_user}
    end 

    private

    def mod_params
        params.require(:reference).permit(:id)
    end 
end


