class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string     :statement
      t.integer    :question_type

      t.timestamps
    end
  end
end
