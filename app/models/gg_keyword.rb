require 'csv'
require 'nokogiri'
require 'open-uri'

class GgKeyword < ActiveRecord::Base
  has_one :gg_result_page, dependent: :destroy
  GOOGLE_SITE = "https://www.google.com"

  def create_keyword_from_csv(file_name)
    file_path = Rails.root.join "public", "#{file_name}"

    CSV.foreach(file_path) do |row|
      row.each do |keyword|
        GgKeyword.create(name: keyword)
      end
    end    
  end

  def get_google_page_with_keyword(keyword)
    page = Nokogiri::HTML(open(GOOGLE_SITE + "/search?#{keyword}"))
  end
end