class UsersController < ApplicationController
    
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate
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
        user = User.new(username: new_user_params["username"], first_name: new_user_params["firstName"], last_name: new_user_params["lastName"], password: new_user_params["password"], start_date: new_user_params["startDate"], roll: "student")
        
        if user.valid?
            # validates user creation, logs new user in
            user.save
            render json: {success: true, token: generate_token(user), userObj: user.serialize_user}
        else
            # if validation fails, responds with errors
            render json: {success: false, errors: user.errors.messages}
        end
        
    end

    # methods below require authentication
    
    def show
        render json: current_user
    end

    def update
       update_params = params.require(:user).permit(:firstName, :lastName, :password, note: {})
       user = current_user
 
       all_category_ids = update_params["note"]["categoryId"] 
       new_note = Note.creation(user, update_params["note"]["noteObj"],all_category_ids)
       if update_params["note"]["newCategory"]
        
        new_category = Category.create(name: update_params["note"]["newCategory"])
        new_note.categories << new_category
        user.notes << new_note
        render json: user.serialize_user
       end
       

   
    end

    def destroy
        #delete user account and personal notes
    end 
    



    private

    # generates the token for front end
    def generate_token(user)
        alg = 'HS256'
        payload = {user_id: user.id}
        JWT.encode(payload, ENV["SEC_KEY"] , alg)
    end 

    def current_user
        @current_user ||= authenticate
    end 

    # validates token and returns the current user
    def authenticate
        
        authenticate_or_request_with_http_token do |token|
         
            begin
                decoded = decode(token)
                @current_user = User.find_by(id: decoded[0]["user_id"])
                
            rescue JWT::DecodeError
                render json: {message: "Thow Shall Not Pass"}, status: 401  
            end
        end 
    end 

    def decode(token)
        JWT.decode(token, ENV["SEC_KEY"], true, { algorithm: 'HS256' })
    end 

   


end
