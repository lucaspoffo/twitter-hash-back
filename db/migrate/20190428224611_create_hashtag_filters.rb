class CreateHashtagFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtag_filters do |t|
      t.string :text

      t.timestamps
    end
  end
end
