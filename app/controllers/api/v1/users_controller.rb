class Api::V1::UsersController < ApplicationController
    require "jwt"
    include SessionHelper

    def create
        # user_infoに、firebaseから発行されたaccess_tokenをデコードした情報(first)を代入する
        user_info = JWT.decode(user_params[:access_token], nil, false).first
        # user_infoのそれぞれのキーの値を、代入する
        name, email, id, picture = user_info.values_at("name", "email", "user_id", "picture")
        # name = user_info["name"]
        # email = user_info["email"]
        # user_id = user_info["user_id"]
        # picture = user_info["picture"]
      
        

        # その値を持ったuserを生成する
        user = User.new(name:, email:, id:, picture:)
        if user.save
          login(user)
          render json: { user: user  }, status: :ok
        elsif User.find(user_id)
          # 複製しているならエラーを出す
          render status: :bad_request
        end
    end

    private

    def user_params
        params.require(:user).permit(:access_token)
    end

end
