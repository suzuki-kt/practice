class MessagesController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_chat_room, only: %i[ create ]

    def create
        Message.create(user_id: @current_user.id, chat_room_id: params[:id], content: params[:content])
        redirect_to request.referer
    end

    def update
        Message.find(params[:id]).update(content: params[:content])
    end

    def destroy
        Message.fild(params[:id]).destroy
    end
end
