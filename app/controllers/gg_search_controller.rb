class GgSearchController < ApplicationController
  def upload_csv
    if params[:file].present?
      UploadWorker.perform_async
      render text: "upload successfully."
    else
      render text: "upload fail."
    end
  end
end