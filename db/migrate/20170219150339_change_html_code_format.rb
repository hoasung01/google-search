class ChangeHtmlCodeFormat < ActiveRecord::Migration
  def change
    change_column :gg_result_pages, :html_code, :text
  end
end
