class AddSlugToLessonAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :slug, :string
    add_column :assignments, :slug, :string
  end
end
