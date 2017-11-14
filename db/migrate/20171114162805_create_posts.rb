class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null:false
      t.timestamp :date, null: false
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true
      t.integer :parent_id, index: true
      t.timestamps
    end
    add_foreign_key :posts, :posts, column: :parent_id, primary_key: :id
  end
end
