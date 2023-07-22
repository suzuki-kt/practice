class AddColumnImageNameToCahtRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_rooms, :image_name, :string, default: "default_image.jpg"
  end
end
