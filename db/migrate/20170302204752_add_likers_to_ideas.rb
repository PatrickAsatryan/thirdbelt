class AddLikersToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :likers, :integer
  end
end
