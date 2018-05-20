class AddPincodeToGists < ActiveRecord::Migration[5.1]
  def change
    add_column :gists, :pincode, :string
  end
end
