class AddIsHiddenToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :is_hidden, :boolean, default: false
  end
end
