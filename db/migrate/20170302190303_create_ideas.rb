class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :content
      t.integer :likecount
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :ideas, :users
  end
end
