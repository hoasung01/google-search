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

  def process_data(data=[])
    @keywords = GgKeyword.where(name: data)

    @keywords.each do |keyword|
      import_data(keyword)
    end
  end

  private
  def import_data(keyword)
    page = Nokogiri::HTML(open(GOOGLE_SITE + "/search?q=#{keyword}"))

    GgResultPage.create(
      number_adword_top: page.css('#center_col').children[1].css('.ads-ad').count,
      number_adword_bottom: page.css('#center_col #bottomads').css('.ads-ad').count,
      adword_total: page.css('#center_col').children[1].css('.ads-ad').count + page.css('#center_col #bottomads').css('.ads-ad').count,
      green_url_adword_top: page.css('#center_col').children[1].css('.ads-ad cite'),
      green_url_adword_bottom: page.css('#center_col #bottomads').css('.ads-ad cite'),
      number_non_adword: page.css('#ires').count,
      url_non_adword: page.css('#ires cite'),
      total_links: page.css('#ires cite').count + page.css('#center_col').children[1].css('.ads-ad').count + page.css('#center_col #bottomads').css('.ads-ad').count,
      total_search: page.css('#resultStats').text.split(' ')[1].split(',').join,
      html_code: page.display,
      gg_keyword_id:
    )
  end

  def max_pages
    1
  end
end