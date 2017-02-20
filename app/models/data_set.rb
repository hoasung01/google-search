class DataSet < ActiveRecord::Base
  has_attached_file :csv_file
  validates_attachment :csv_file, presence: true, content_type: {content_type: 'text/csv'}
end