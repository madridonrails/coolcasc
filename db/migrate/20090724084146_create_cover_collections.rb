class CreateCoverCollections < ActiveRecord::Migration
  def self.up
    create_table :cover_collections do |t|
      t.string :name
      t.string :short_description
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :cover_collections
  end
end
