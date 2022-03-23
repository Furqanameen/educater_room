class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.references :user, foreign_key: true, index: true
      t.references :answer, foreign_key: true, index: true

      t.timestamps
    end
  end
end
