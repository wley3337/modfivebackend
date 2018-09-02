class UsersController < ApplicationController
    
   
    skip_before_action :authenticate, only: [:login, :create]

    def login
        # local strong params
        login_params = params.require(:user).permit(:username, :password)
        user = User.find_by(username: login_params["username"])
        password = login_params[:password]
        
        if user && user.authenticate(password)
            # generates token returns user
            @current_user = user
            render json: {success: true, token: generate_token(user), userObj: user.serialize_user}
        else 
            # returns false for frontend response
            render json: {success: false}
        end 
    end 

    def create
        # local strong params
        new_user_params = params.require(:user).permit(:username, :firstName, :lastName, :startDate, :password)
        debugger
        user = User.new(username: new_user_params["username"], first_name: new_user_params["firstName"], last_name: new_user_params["lastName"], password: new_user_params["password"], start_date: new_user_params["startDate"], roll: "student")
        
        if user.valid?
            # validates user creation, logs new user in
            user.save
            @current_user = user
            render json: {success: true, token: generate_token(user), userObj: user.serialize_user}
        else
            # if validation fails, responds with errors
            render json: {success: false, errors: user.errors.messages}
        end
        
    end

    # methods below require authentication
    
    def show
        render json:  {success: true,  userObj: current_user.serialize_user}
    end

    def update
       update_params = params.require(:user).permit(:firstName, :lastName, :password, note: {})
       user = current_user
       public_note = update_params["note"]["public"] 
       all_category_ids = update_params["note"]["categoryId"]
       if update_params["note"]["noteId"]
        note_change = Note.find(update_params["note"]["noteId"])
            if note_change.user_id === user.id
                note_change.update_note(update_params["note"]["noteObj"],all_category_ids, public_note)
            else
                note_change = Note.creation(user, update_params["note"]["noteObj"],all_category_ids, public_note)
            end
       elsif
         note_change = Note.creation(user, update_params["note"]["noteObj"],all_category_ids, public_note)
       end
       if update_params["note"]["newCategory"] != ""

        new_category = Category.create(name: update_params["note"]["newCategory"])
        note_change.categories << new_category
        user.notes << note_change
       end
       render json: {success: true,  userObj: current_user.serialize_user}

   
    end

    def destroy
        #delete user account and personal notes
    end 
    



  

   


end
