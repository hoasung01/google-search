class Api::V1::GoogleSearchController < Api::V1::BaseController
  def report
    respond_with(GgResultPage.joins(:gg_keyword).order("gg_keywords.name DESC").page params[:page])
  end

  def upload_csv
    #
  end

  def query
    #
  end
end