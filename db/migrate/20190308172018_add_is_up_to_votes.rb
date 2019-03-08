class AddIsUpToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :is_up, :boolean
  end
end
