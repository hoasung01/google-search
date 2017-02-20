class UploadWorker
  include Sidekiq::Worker

  def self.perform(csv_file)
    Rails.logger.info("perform start")
    begin
      GgKeyword.create_keyword(csv_file)
      GgKeyword.new().process_data
    rescue
      nil
    end
    Rails.logger.info("perform end")
  end
end