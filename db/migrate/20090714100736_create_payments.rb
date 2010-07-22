class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.string :name
      t.text :description
      t.integer :days_from_invoice
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
