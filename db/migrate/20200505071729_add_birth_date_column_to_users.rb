class AddBirthDateColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birth_date, :datetime
    add_column :users, :contact, :string
    add_column :users, :specialization, :string
    add_column :users, :highest_education, :string
  end
end
