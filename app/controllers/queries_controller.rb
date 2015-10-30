class QueriesController < ApplicationController
  before_action :authenticate

  def query
    @payload = SlerkSchema.execute(params[:query], query_params)
    render json: @payload
  end

  private

  def query_params
    {
      context: { current_user: @current_user },
      variables: params[:variables]
    }
  end
end
