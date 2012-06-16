class LegalController < ApplicationController
  before_each :set_location

  def tos
  end

  def support
  end

  def privacy
  end

  private

  def set_location
    @location = "Legal"
  end
end
