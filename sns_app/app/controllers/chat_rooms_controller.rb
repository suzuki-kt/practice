class ChatRoomsController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_chat_room, only: %i[ show edit update destroy ]

    def index
        @chat_rooms = @current_user.chat_rooms
    end

    def show
        @chat_room = ChatRoom.find(params[:id])
        @messages = Message.where(chat_room_id: params[:id]).order(created_at: "desc")
        @users = @chat_room.users
    end

    def new
        @users = @current_user.followees
    end

    def create
        
        if params[:private_flag]
            @chat_room = ChatRoom.new(private_flag: params[:private_flag])
        else
            @chat_room = ChatRoom.new(name: params[:name])
        end
        @chat_room.save
        params[:user_ids].each do |user_id|
            ChatRoomUser.create(chat_room_id: @chat_room.id, user_id: user_id)
        end
        ChatRoomUser.create(chat_room_id: @chat_room.id, user_id: @current_user.id)
        redirect_to chat_room_path(@chat_room), notice: "チャットルームを作成しました"
    end

    def edit
        @chat_room = ChatRoom.find(params[:id])
        @messages = Message.where(chat_room_id: params[:id]).order(created_at: "asc")
        @users = @chat_room.users
    end

    def update
        @chat_room = ChatRoom.find(params[:id])
        @chat_room.update(name: params[:chat_room_name])
        redirect_to @chat_room
    end

    def destroy
        ChatRoom.find(params[:id]).destroy
    end
end
