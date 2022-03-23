class CreateCourseSections < ActiveRecord::Migration[5.2]
  def change
    create_table :course_sections do |t|
      t.references :section, foreign_key: true, index: true
      t.references :course, foreign_key: true, index: true

      t.timestamps
    end
  end
end
