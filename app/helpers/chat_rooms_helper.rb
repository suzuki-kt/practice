module ChatRoomsHelper
    def chat_room_name(chat_room)
        if chat_room.private_flag
            user = chat_room.users.where.not(id: @current_user.id)[0]
            return user
        else
            if chat_room.name == nil || chat_room.name == ""
                chat_room_name = "名前なし"
            else
                chat_room_name = chat_room.name
            end
            return chat_room_name
        end
        
    end

    def chat_room_button(user)
        if user != @current_user
            chat_rooms = user.chat_rooms & @current_user.chat_rooms & ChatRoom.where(private_flag: true)
            chat_room = chat_rooms[0]
            if chat_room
                button_to "チャット", chat_room_path(chat_room), method: :get
            else
                button_to "チャット", chat_rooms_path('user_ids[]': user.id, private_flag: true)
            end
        end
    end
end
