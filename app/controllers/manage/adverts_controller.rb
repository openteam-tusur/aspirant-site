class Manage::AdvertsController < Manage::ApplicationController
  load_and_authorize_resource

  before_action :set_advert, only: [:destroy, :update, :show]
  def index
    @adverts = Advert.all
    render partial: 'manage/angular/adverts', locals: { adverts: @adverts }
  end

  def show
    render partial: 'manage/angular/advert', locals: { advert: @advert }
  end

  private
  def set_advert
    @advert = Advert.find(params[:id])
  end
end
