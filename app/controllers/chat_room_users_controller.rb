class ChatRoomUsersController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_chat_room, only: %i[ create edit destroy ]

    def create
        chat_room = ChatRoom.find(params[:id])
        params[:user_ids].each do |user_id|
            ChatRoomUser.create(chat_room_id: chat_room.id, user_id: user_id)
        end
        redirect_to chat_room, notice: "#{chat_room.name}にユーザーが参加しました"
    end

    def destroy
        chat_room = ChatRoom.find(params[:id])
        params[:user_ids].each do |user_id|
            ChatRoomUser.find_by(chat_room_id: chat_room.id, user_id: user_id).destroy
        end
        if chat_room.users.count < 2
            chat_room.destroy
            redirect_to chat_rooms_path, notice: "チャットルームを削除しました"
        else
            redirect_to chat_room_path(chat_room), notice: "#{chat_room.name}からユーザーを削除しました"
        end
        
    end

    def edit
        @chat_room = ChatRoom.find(params[:id])
        @joined_users = @chat_room.users
        @no_joined_users = @chat_room.no_joined_users(@current_user)

    end
end
