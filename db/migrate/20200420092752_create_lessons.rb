class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.references :course_section, foreign_key: true, index: true

      t.string     :title

      t.timestamps
    end
  end
end
