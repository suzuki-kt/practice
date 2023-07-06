class RemoveReceiverIdFromChatRoom < ActiveRecord::Migration[7.0]
  def change
    remove_column :chat_rooms, :receiver_id
  end
end
