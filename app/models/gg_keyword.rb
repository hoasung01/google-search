require 'csv'

class GgKeyword < ActiveRecord::Base
  has_one :gg_result_page, dependent: :destroy

  def create_keyword_from_csv(file_name)
    file_path = Rails.root.join "public", "#{file_name}"

    CSV.foreach(file_path) do |row|
      row.each do |keyword|
        GgKeyword.create(name: keyword)
      end
    end    
  end
end