class Manage::PeopleController < Manage::ApplicationController
  load_and_authorize_resource

  before_filter :find_context, only: :create

  attr_accessor :context

  def create
    @person = Person.where(person_params).first_or_create
    Post.where(person: @person, context: context, title: title, person_type: params[:person_type])
        .first_or_create
    render partial: 'manage/angular/person', locals: { person: @person, context: context }
  end

  def search
    @result = Searcher::PeopleSearcher.new(search_params).collection
    render partial: 'manage/angular/people', locals: { people: @result }
  end

  def directory_search
    url = "#{Settings['directory.users_search']}?q=#{URI.encode params[:term]}"
    @response = JSON.parse RestClient::Request.execute(method: :get, url: url, timeout: 90)

    render json: @response.take(4)
  end

  def update_order
    @post = Post.find_by person_id: params[:id],
                         context_id: params[:context_id],
                         context_type: params[:context_type]

    render json: @post.update_attribute(:row_order_position, params[:index])
  end

  def remove_from_advert
    post = Person.find(params[:id]).posts.find_by(remove_params)
    render json: !!post.destroy
  end

  private

  def remove_params
    params.permit(:context_id, :context_type, :person_type)
  end

  def find_context
    @context ||= params[:context_type].constantize.find(params[:context_id])
  end

  def person_params
    params.require(:person)
          .except(:post, :speciality)
          .permit( :id, :name, :surname, :patronymic,
                   :science_degree, :science_degree_abbr,
                   :science_title,  :science_title_abbr,
                   :council_speciality_id,:directory_id,
                   :work_place, :work_post, :url
                  )
  end

  def title
    params[:person][:post][:title] rescue ''
  end

  def search_params
    %w(q ids).each_with_object({}){ |key, hash| hash[key.to_sym] = params[key] }
  end

end
