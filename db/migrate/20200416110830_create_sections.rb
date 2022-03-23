class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.references :batch, foreign_key: true, index: true

      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
