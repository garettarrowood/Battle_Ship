class CreateShips < ActiveRecord::Migration[5.0]
  def change
    create_table :ships do |t|
      t.references :board
      t.point :positions, array: true
      t.string :classification
      t.timestamps
    end
  end
end
