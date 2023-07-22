class ChengeColumnDefault < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :image_name
    add_column :users, :image_name, :string, default: "default_image.jpg"
  end
end
