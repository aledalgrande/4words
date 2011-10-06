class AddHtmlToSquares < ActiveRecord::Migration
  def change
    add_column :squares, :html, :text
  end
end
