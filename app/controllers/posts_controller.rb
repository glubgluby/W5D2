class PostsController < ApplicationController

    before_action :ensure_logged_in

    def new
        @post = Post.new
        render :new
    end

    def edit
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])
        @post.sub_ids = params[:post][:sub_ids]
        unless params[:post][:sub_ids].empty? || !@post.update_attributes(post_params)
            render :show
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def create
        @post = Post.new(post_params)
        @post.sub_ids = params[:post][:sub_ids]
        unless params[:post][:sub_ids].empty? || !@post.save
            render :show
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find(params[:id])
        render :show
    end

    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to subs_url
    end

    private 

    def post_params
        params.require(:post).permit(:title, :url, :content, :author_id)
    end

end