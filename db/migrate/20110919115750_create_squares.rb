class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height
      t.string :colour, :default => '808285'
      t.boolean :taken, :default => false

      t.timestamps
    end
  end
end
