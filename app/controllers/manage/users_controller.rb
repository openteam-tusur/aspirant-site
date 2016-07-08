require 'restclient/components'
require 'rack/cache'

class Manage::UsersController < Manage::ApplicationController

  def search
    search_url = URI.encode("#{Settings['profile.users_url']}?term=#{params[:term]}")

    RestClient.enable Rack::CommonLogger
    RestClient.enable Rack::Cache,
      metastore:   "file:#{Rails.root.join('tmp/rack-cache/meta')}",
      entitystore: "file:#{Rails.root.join('tmp/rack-cache/body')}",
      verbose:     true

    result = RestClient::Request.execute(
      :method => :get,
      :url => search_url,
      :timeout => nil,
      :headers => {
        :Accept => 'application/json'
      }
    ) do |response, request, result, &block|
      response
    end

    render :json => result rescue {}
  end

  def persons_search
    @result = Searcher::PeopleSearcher.new(q: params[:q]).collection
    render partial: 'manage/angular/persons', locals: { persons: @result }
  end

  def directory_search
     url = "#{Settings['directory.users_search']}?q=#{URI.encode params[:term]}"
     @response = JSON.parse RestClient::Request.execute(method: :get, url: url, timeout: 90)

     render json: @response
   end

end
