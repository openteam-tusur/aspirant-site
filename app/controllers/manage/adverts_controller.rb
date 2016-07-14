class Manage::AdvertsController < Manage::ApplicationController
  def index
    @adverts = Advert.all
    render partial: 'manage/angular/adverts', locals: { adverts: @adverts }
  end
end
