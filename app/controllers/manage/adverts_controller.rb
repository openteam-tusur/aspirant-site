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

  def update
    @advert = Advert.find(params[:id])
    @advert.update_attributes(update_params)
    render partial: 'manage/angular/advert', locals: { advert: @advert }
  end

  private
  def set_advert
    @advert = Advert.find(params[:id])
  end

  def update_params
    params
      .require(:advert)
      .permit( %w(
                  title council_speciality_id
                  dissertation_council_id
                  publication_date place
                  ).map(&:to_sym)
              )
  end
end
