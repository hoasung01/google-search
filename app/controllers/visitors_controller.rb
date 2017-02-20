class VisitorsController < ApplicationController
  def report
    @results = GgResultPage.all
  end
end
