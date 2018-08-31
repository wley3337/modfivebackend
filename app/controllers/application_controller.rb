class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate
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
