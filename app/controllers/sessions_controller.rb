class SessionsController < ApplicationController
    def create 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password]) # check if user exists and has a matching password
            session[:user_id] = user.id
            render json: user
        else
            render json: { errors: ['Invalid username or password'] }, status: :unauthorized
        end
    end

    def destroy
        session.delete(:user_id)
        head :no_content
    end
end
