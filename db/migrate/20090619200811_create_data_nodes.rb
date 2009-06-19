class CreateDataNodes < ActiveRecord::Migration
  def self.up
    create_table :data_nodes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :data_nodes
  end
end
