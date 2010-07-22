class CreateShippings < ActiveRecord::Migration
  def self.up
    create_table :shippings do |t|
      t.string :company
      t.float :weight_from
      t.float :weight_to
      t.timestamps
    end
  end

  def self.down
    drop_table :shippings
  end
end
