require 'csv'
require 'nokogiri'
require 'open-uri'
require 'iconv' unless String.method_defined?(:encode)

class GgKeyword < ActiveRecord::Base
  include AASM
  has_one :gg_result_page, dependent: :destroy
  GOOGLE_SITE = "https://www.google.com"

  aasm column: :state, whiny_transitions: false do
    state :on, initial: true
    state :off

    event :switch do
      transitions from: [:on], to: :off
    end 
  end

  def self.create_keyword(file_path)
    CSV.foreach(file_path) do |row|
      row.each do |keyword|
        GgKeyword.create(name: keyword)
      end
    end
  end

  def process_data
    @keywords = GgKeyword.where(state: ["on"])

    @keywords.each do |keyword|
      import_data(keyword)
      keyword.switch!
    end
  end

  private
  def import_data(keyword)
    page = Nokogiri::HTML(open(GOOGLE_SITE + "/search?q=#{keyword.name}"))

    GgResultPage.create!(
      number_adword_top: page.css('#center_col').children[1].css('.ads-ad').count,
      number_adword_bottom: page.css('#center_col #bottomads').css('.ads-ad').count,
      adword_total: page.css('#center_col').children[1].css('.ads-ad').count + page.css('#center_col #bottomads').css('.ads-ad').count,
      green_url_adword_top: page.css('#center_col').children[1].css('.ads-ad cite').to_a.map{|x| x.text},
      green_url_adword_bottom: page.css('#center_col #bottomads').css('.ads-ad cite').to_a.map{|x| x.text},
      number_non_adword: page.css('#ires cite').to_a.count,
      url_non_adword: page.css('#ires cite').to_a.map{|x| x.text},
      total_links: page.css('#ires cite').count + page.css('#center_col').children[1].css('.ads-ad').count + page.css('#center_col #bottomads').css('.ads-ad').count,
      total_search: page.css('#resultStats').text.split(' ')[1].split(',').join,
      html_code: page.to_s.encode!('UTF-8', 'UTF-8', invalid: :replace),
      gg_keyword_id: keyword.id,
    )
  end
end