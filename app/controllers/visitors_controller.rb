class VisitorsController < ApplicationController  
  def report
    @results = GgResultPage.joins(:gg_keyword).order("gg_keywords.name DESC").page params[:page]
  end

  def upload_csv
    @data_set = DataSet.create(data_set_params)
    respond_to do |format|
      if @data_set.valid?
        UploadWorker.perform(@data_set.csv_file.path)
        format.html {redirect_to '/'}
      else
        format.js {render json: @data_set.errors, status: false}
      end
    end
  end

  def query
    
  end

  private
    def data_set_params
      params.fetch(:data_set, {}).permit(:csv_file)
    end
end