module SessionHelper
    extend ActiveSupport::Concern
  
    def login(user)
      # if user.nil?
      #   false
      # else
        session[:user_id] = user.id
        # cookies["user_id"] = {
        #   # cookieの値をuser.idとする  
        #   value: user.id,
        #   # cookieの有効期限
        #   max_age: 3600 * 24 * 7,
        #   # httpsでクッキーを送信
        #   secure: true,
        #   same_site: Rails.env.production? ? :none : :lax,
        # }
        # cookies["logged_in"] = {
        #   value: true,
        #   max_age: 3600 * 24 * 7,
        #   secure: true,
        #   same_site: Rails.env.production? ? :none : :lax,
        # }
        true
      # end
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