class QueriesController < ApplicationController
  before_action :authenticate

  def query
    @payload = SlerkSchema.execute(params[:query], query_context)
    render json: @payload
  end

  private

  def query_context
    { context: { current_user: @current_user } }
  end
end
