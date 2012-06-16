class ErrorsController < ApplicationController
  before_each :set_location

  def not_found
  end

  private

  def set_location
    @location = "Error"
  end
end
