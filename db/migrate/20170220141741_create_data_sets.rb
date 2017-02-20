class CreateDataSets < ActiveRecord::Migration
  def change
    create_table :data_sets do |t|

      t.timestamps null: false
    end
    add_attachment :data_sets, :csv_file
  end
end