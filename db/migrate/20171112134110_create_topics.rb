class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.timestamp :date, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
