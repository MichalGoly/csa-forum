class CreatePostsReads < ActiveRecord::Migration[5.1]
  def change
    create_table :posts_reads do |t|
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
