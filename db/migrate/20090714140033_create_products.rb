class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :code
      t.string :name
      t.string :description
      t.float :cost_price
      t.float :retail_price
      t.float :wholesale_price
      t.float :weight
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.integer :cover_collection_id
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
