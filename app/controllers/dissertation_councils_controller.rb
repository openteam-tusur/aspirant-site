class DissertationCouncilsController < ApplicationController
  def index
    @dissertation_councils = DissertationCouncil.all
  end
end
