class UploadWorker
  include Sidekiq::Worker

  def self.perform(csv_file, data)
    log("perform start")
    log("perform end")
  end
end