class VisitorsController < ApplicationController  
  def report
    @results = GgResultPage.all
  end

  def upload_csv
    @data_set = DataSet.create(data_set_params)
  end

  private
    def data_set_params
      params.fetch(:data_set, {}).permit(:csv_file)
    end
end