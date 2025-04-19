# Migration para adicionar índice único à tabela de ratings
class AddUniqueIndexToRatings < ActiveRecord::Migration[7.1]
  def change
    add_index :ratings, [:user_id, :post_id], unique: true
  end
end
