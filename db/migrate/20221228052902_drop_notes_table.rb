class DropNotesTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :notes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
