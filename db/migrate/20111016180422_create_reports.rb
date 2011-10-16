class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :square_id
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
