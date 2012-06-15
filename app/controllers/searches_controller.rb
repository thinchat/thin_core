class SearchesController < ApplicationController
  def show
    @query = params[:query]
    @query = @query.sub(" ", ",") if @query
  end
end
