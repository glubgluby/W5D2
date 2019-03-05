class CommentsController < ApplicationController

    before_action :ensure_logged_in

    def show
        @comment = Comment.find(params[:id])
        render :show
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.author = current_user
        @comment.save
        flash[:errors] = @comment.errors.full_messages
        redirect_to post_url(@comment.post)
    end

    private
    def comment_params
        params.require(:comment).permit(:body, :parent_comment_id, :post_id)
    end

end