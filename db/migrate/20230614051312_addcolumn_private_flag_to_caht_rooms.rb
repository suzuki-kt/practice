class AddcolumnPrivateFlagToCahtRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_rooms, :private_flag, :boolean, default: false
  end
end
