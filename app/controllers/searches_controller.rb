class SearchesController < ApplicationController
  def show
    @location = "Search"
    @query = params[:query]
    @query = @query.sub(" ", ",") if @query
  end
end
