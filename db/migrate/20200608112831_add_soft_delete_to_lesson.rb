class AddSoftDeleteToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :deleted_at, :datetime
    add_index :lessons, :deleted_at
  end
end
