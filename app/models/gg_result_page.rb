class GgResultPage < ActiveRecord::Base
  serialize :url_non_adword, Array
  serialize :green_url_adword_top, Array
  serialize :green_url_adword_bottom, Array
  belongs_to :gg_keyword
  delegate :name, to: :gg_keyword, allow_nil: true, prefix: true
end