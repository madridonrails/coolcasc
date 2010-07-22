class CreateSalesManagers < ActiveRecord::Migration
  def self.up
    create_table :sales_managers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :email
      t.integer :market_id
      t.integer :product_family_id
      t.integer :commission

      t.string :corporate_name
      t.string :cif
      t.string :official_address
      t.string :charge


      t.timestamps
    end
  end

  def self.down
    drop_table :sales_managers
  end
end
