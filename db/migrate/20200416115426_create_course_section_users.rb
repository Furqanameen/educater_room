class CreateCourseSectionUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :course_section_users do |t|
      t.references :course_section, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
