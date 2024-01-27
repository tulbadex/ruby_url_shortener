class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.string :descripton
      t.string :image
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
