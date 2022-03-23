class AddDeletedAtToBatches < ActiveRecord::Migration[5.2]
  def change
    add_column :batches, :deleted_at, :datetime
    add_index :batches, :deleted_at
  end
end
