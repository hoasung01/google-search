class Api::V1::BaseController < ActionController::Base
  before_action :validate_request_format
  respond_to :json

  def validate_request_format
    if (format = params[:format]) != 'json'
      render json: {status: false, message: t('api.v1.google_search.error.wrong_format', request_format: format)}
    end
  end
end