class GgKeyword < ActiveRecord::Base
  has_one :gg_result_page, dependent: :destroy
end
