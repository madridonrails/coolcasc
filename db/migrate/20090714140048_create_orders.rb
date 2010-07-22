class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :code
      t.string :order_date
      t.integer :client_id
      t.text :notes
      t.string :delivery_date
      t.boolean :deposit
      t.boolean :freight_in_invoice
      t.boolean :is_paid
      t.integer :amount_paid
      t.string :paid_date
      t.integer :company_discount
      t.integer :sales_manager_discount
      t.integer :exhibitors
      t.integer :catalogs
      t.boolean :urgent
      t.string :state


      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
