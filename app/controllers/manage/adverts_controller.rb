class Manage::AdvertsController < Manage::ApplicationController
  load_and_authorize_resource

  def index
    render partial: 'manage/angular/adverts', locals: { adverts: @adverts }
  end

  def show
    render partial: 'manage/angular/advert', locals: { advert: @advert }
  end

  def update
    @advert.update_attributes(update_params)
    render partial: 'manage/angular/advert', locals: { advert: @advert }
  end

  def publish
    @advert.publish!
    render json: { state: @advert.aasm_state }
  end

  def unpublish
    @advert.unpublish!
    render json: { state: @advert.aasm_state }
  end

  def versions
    @versions = @advert.versions
    render partial: 'manage/angular/versions', locals: { versions: @versions }
  end

  def create
    council = current_user.available_contexts.sample()
    @advert.dissertation_council = council

    @advert.save

    render partial: 'manage/angular/advert', locals: { advert: @advert }
  end

  def destroy
    render json: @advert.destroy
  end

  private

  def update_params
    params.require(:advert)
          .permit %w(
                      organization_name science_degree title council_speciality_id
                      dissertation_council_id publication_date place
                    ).map(&:to_sym)
  end
end
