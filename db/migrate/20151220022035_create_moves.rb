class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.references :board
      t.point :position
      t.timestamps
    end
  end
end
