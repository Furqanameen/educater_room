class AddAdditionalInforamtionJsonColumnToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :additional_information, :json
  end
end
