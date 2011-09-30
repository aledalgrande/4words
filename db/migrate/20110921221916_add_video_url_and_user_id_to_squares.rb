class AddVideoUrlAndUserIdToSquares < ActiveRecord::Migration
  def change
    add_column :squares, :video_url, :string
    add_column :squares, :user_id, :integer
  end
end
