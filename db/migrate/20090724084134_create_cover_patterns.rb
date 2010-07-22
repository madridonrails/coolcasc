class CreateCoverPatterns < ActiveRecord::Migration
  def self.up
    create_table :cover_patterns do |t|
      t.string :pattern
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :cover_patterns
  end
end
