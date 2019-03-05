class SessionsController < ApplicationController



    def create
        user = User.find_by_credentials(params[:user][:username],params[:user][:password])
        if user
            login!(user)
            redirect_to subs_url
        else
            flash.now[:errors] = ['wrong username/password']
            render :new
        end
    end

    def destroy
        logout!
        render :new
    end


end