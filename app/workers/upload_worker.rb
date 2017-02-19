class UploadWorker
  include Sidekiq::Worker

  def perform(*args)
    log("perform start")
    log("perform end")
  end
end
