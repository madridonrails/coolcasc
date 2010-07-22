class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :code
      t.text :description
      t.string :currency
      t.text :currency_description
      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
