class SubsController < ApplicationController

    before_action :ensure_logged_in

    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        
        if @sub.save
            render :show
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end

    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub.update_attributes(sub_params)
            render :show
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end

    end

    def index 
        @subs = Sub.all
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    private

    def sub_params
        params.require(:sub).permit(:moderator_id, :title, :description)
    end

end
