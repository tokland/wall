class CreateLiveClasses < ActiveRecord::Migration
  def self.up
    create_table :live_classes do |t|
      t.integer :creator_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :live_classes
  end
end
