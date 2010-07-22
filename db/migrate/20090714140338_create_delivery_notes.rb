class CreateDeliveryNotes < ActiveRecord::Migration
  def self.up
    create_table :delivery_notes do |t|
      t.integer :order_id
      t.string :code
      t.string :delivery_date
      t.timestamps
    end
  end

  def self.down
    drop_table :delivery_notes
  end
end
