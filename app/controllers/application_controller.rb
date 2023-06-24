class ApplicationController < ActionController::API
    include SessionHelper
    def logged_in_user
        unless logged_in?
            render json: { error: 2 }, status: :unauthorized
        end
    end
end
