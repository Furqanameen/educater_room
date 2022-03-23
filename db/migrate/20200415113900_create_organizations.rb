class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.references :user
      t.string     :name
      t.string     :ouid

      t.timestamps
    end
  end
end
