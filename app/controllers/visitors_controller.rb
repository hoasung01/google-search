class VisitorsController < ApplicationController  
  def report
    @results = GgResultPage.all
  end

  def upload_csv
    @data_set = DataSet.create(data_set_params)
    respond_to do |format|
      if @data_set.valid?
        format.html {redirect_to '/'}
      else
        format.js {render json: @data_set.errors, status: false}
      end
    end
  end

  private
    def data_set_params
      params.fetch(:data_set, {}).permit(:csv_file)
    end
end