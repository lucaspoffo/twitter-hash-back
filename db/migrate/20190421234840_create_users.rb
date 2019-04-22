class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: false do |t|
      t.integer :id, :limit => 8
      t.string :name
      t.string :screen_name
      t.string :profile_image_url

      t.timestamps
    end
    add_index :users, :id, unique: true
  end
end
