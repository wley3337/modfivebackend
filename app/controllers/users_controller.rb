class UsersController < ApplicationController
    
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authorized
    skip_before_action :authorized, only: [:login, :create]

    def login
        # local strong params
        login_params = params.require(:user).permit(:username, :password)
        user = User.find_by(username: login_params["username"])
        password = login_params[:password]
        
        if user && user.authenticate(password)
            # generates token returns user
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

    end

    def destroy
        #delete user account and personal notes
    end 
    



    private

    # generates the token for front end
    def generate_token(user)
        alg = 'HS256'
        payload = {user_id: user.id}
        secret = ENV["SEC_KEY"]
        JWT.encode payload, secret, alg
    end 

    # validates token and returns the current user
    def current_user
        authenticate_or_request_with_http_token do |jwt_token, options|
            begin
                decoded_token = JWT.decode(jwt_token, ENV["SEC_Key"])

            rescue JWT::DecodeError
                return nil
            end 

            if decoded_token[0]["user_id"]
                @current_user ||= User.find(decoded_token[0]["user_id"])
            else 
            end
        end 
    end 

    # converts results of current user to boolean as a helper function
    def logged_in?
        !!current_user
    end 

    # returns a 401 message to front end if token is not decodable/valid
    def authorized
        render json: {message: "Thow Shall Not Pass"}, status: 401 unless logged_in?
    end 


end
