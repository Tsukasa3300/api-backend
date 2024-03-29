module SessionHelper
    extend ActiveSupport::Concern
  
    def login(user)
      session[:user_id] = user.id
    end
  
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])   
      end     
    end

            
    def logged_in?
      !current_user.nil?
    end
  
end