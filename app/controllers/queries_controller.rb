class QueriesController < ApplicationController
  def query
    @payload = SlerkSchema.execute(params[:query])
    render json: @payload
  end
end
