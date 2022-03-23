class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches do |t|
      t.string :title
      t.text :description
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.timestamps
    end
  end
end
