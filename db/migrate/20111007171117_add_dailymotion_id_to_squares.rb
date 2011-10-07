class AddDailymotionIdToSquares < ActiveRecord::Migration
  def change
    add_column :squares, :dailymotion_id, :string
  end
end
