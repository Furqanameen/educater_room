class AddSlugsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :slug, :string
    add_column :batches, :slug, :string
    add_column :quizzes, :slug, :string
  end
end
