class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def set_user
        @user = User.find(params[:id])
    end

    def authenticate_user
        if !@current_user
            redirect_to login_path, notice: "ログインしてください"
        end
    end

    def forbid_login_user
        if @current_user
            redirect_to request.referer, notice: "すでにログインしています"
        end
    end

    def ensure_correct_user
        if @current_user
            if @current_user.id != params[:id].to_i
                redirect_to @current_user, notice: "権限がありません"
            end
        end
    end

    def ensure_correct_post
        if @post
            if @post.user_id != @current_user.id
                redirect_to @post, notice: "権限がありません"
            end
        end
    end

    def ensure_correct_chat_room
        if !ChatRoomUser.find_by(user_id: @current_user, chat_room_id: params[:id])
            redirect_to chat_rooms_path(@current_user), notice: "権限がありません"
        end
    end

    def ensure_correct_relationship
        if Relationship.find(params[:id]).follower_id != @current_user.id
            redirect_to @current_user, notice: "権限がありません"
        end
    end
end
