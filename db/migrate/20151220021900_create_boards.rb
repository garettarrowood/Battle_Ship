class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.references :game
      t.string :owner
      t.timestamps
    end
  end
end
