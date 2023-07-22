class RelationshipsController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_relationship, only: %i[destroy]

    def create
        Relationship.create(follower_id: @current_user.id, followee_id: params[:followee_id])
        redirect_to request.referer
    end

    def show_follower
        @user = User.find(params[:id])
        @users = @user.followers
        @tab = "follower"
        render "users/show"
    end

    def show_followee
        @user = User.find(params[:id])
        @users = @user.followees
        @tab = "followee"
        render "users/show"
    end

    def destroy
        Relationship.find(params[:id]).destroy
        redirect_to request.referer
    end
end
