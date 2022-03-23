class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true, index: true

      t.boolean    :is_correct
      t.string     :statement

      t.timestamps
    end
  end
end
