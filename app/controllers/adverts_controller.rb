class AdvertsController < ApplicationController
  def index
    @adverts = Advert.publicated
  end

  def show
    @advert = Advert.find(params[:id])
  end
end
