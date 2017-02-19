class UploadWorker
  include Sidekiq::Worker

  def perform(csv_file, data)
    log("perform start")
    GgKeyword.new().process_data
    log("perform end")
  end
end