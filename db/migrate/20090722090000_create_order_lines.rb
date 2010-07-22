class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|

      t.boolean :group
      t.integer :cover_pattern_id
      t.integer :product_id
      t.integer :order_id
      t.integer :count
      t.boolean :marked
      t.integer :mark_id
      t.integer :mark_price

      t.timestamps
    end
  end

  def self.down
    drop_table :order_lines
  end
end
