class AddStateToGgKeywords < ActiveRecord::Migration
  def change
    add_column :gg_keywords, :state, :string
  end
end
