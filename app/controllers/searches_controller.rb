class SearchesController < ApplicationController
  def show
    @query = params[:query]
    raise params.inspect
  end
end
