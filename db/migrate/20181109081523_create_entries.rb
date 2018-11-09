class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :title
      t.datetime :published
      t.text :context
      t.string :url
      t.string :author
      t.integer :feed_id

      t.timestamps
    end
  end
end
