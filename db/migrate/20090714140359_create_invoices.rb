class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :order_id
      t.string :code
      t.string :delivery_date
      t.string :charge_date
      t.float :amount_charged
      t.float :freight
      t.string :state
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
