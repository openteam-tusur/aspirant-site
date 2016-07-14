class Manage::CouncilSpecialitiesController < Manage::ApplicationController
  def search
    @result = Searcher::CouncilSpecialitySearcher.new(search_params).collection
    render partial: 'manage/angular/council_specialities', locals: { specialities: @result }
  end

  def create
    @speciality = CouncilSpeciality.where(speciality_params).first_or_create
    council = DissertationCouncil.find(params[:council_id])
    CouncilSpecialitiesDissertationCouncil
      .where(dissertation_council: council, council_speciality: @speciality)
      .first_or_create
    render partial: 'manage/angular/council_speciality', locals: { speciality: @speciality }
  end

  def remove_from_council
    link = CouncilSpecialitiesDissertationCouncil
      .find_by council_speciality_id:   params[:id],
               dissertation_council_id: params[:council_id]
    render json: !!link.destroy
  end

  def update_order
    link = CouncilSpecialitiesDissertationCouncil
      .find_by council_speciality_id:   params[:id],
               dissertation_council_id: params[:council_id]
    render json: link.update_attribute(:row_order_position, params[:index])
  end

  private

  def search_params
    %w(q ids).each_with_object({}){ |key, hash| hash[key.to_sym] = params[key] }
  end

  def speciality_params
    params.require(:speciality).permit(:id, :title, :code, :science_type)
  end
end
