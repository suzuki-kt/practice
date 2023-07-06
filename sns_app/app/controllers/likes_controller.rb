class LikesController < ApplicationController
    before_action :authenticate_user
    before_action :set_user, only: %i[show]

    def show
        @posts = @user.like_posts.order(created_at: "desc")
        @tab = "like"
        render "users/show"
    end

    def create
        Like.create(user_id: @current_user.id, post_id: params[:id])
        redirect_to request.referer
    end

    def destroy
        Like.find_by(user_id: @current_user.id, post_id: params[:id]).destroy
        redirect_to request.referer
    end
end
