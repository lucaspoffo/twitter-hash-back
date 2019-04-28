class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets, id: false do |t|
      t.integer :id, :limit => 8
      t.string :text
      t.references :user, foreign_key: true
      t.datetime :created_at

      t.timestamps
    end
    add_index :tweets, :id, unique: true
  end
end
