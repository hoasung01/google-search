class CreateGgResultPages < ActiveRecord::Migration
  def change
    create_table :gg_result_pages do |t|
      t.integer :number_adword_top
      t.integer :number_adword_bottom
      t.integer :adword_total
      t.string :green_url_adword_top
      t.string :green_url_adword_bottom
      t.integer :number_non_adword
      t.string :url_non_adword
      t.integer :total_links
      t.integer :total_search
      t.string :html_code
      t.references :gg_keyword, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
