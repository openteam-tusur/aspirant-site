class CacheWorker
  include Sidekiq::Worker

  attr_accessor :url

  def perform(url)
    @url = url
    logger.info "url: #{url}"
    logger.info "request status: #{rest_request[:code]}"
    if rest_request[:code] == 200
      Rails.cache.write(url, String.new(rest_request.to_json))
    else
      Rails.cache.delete(url)
    end
  end

  private

  def rest_request
    RestClient::Request.execute(
      method: :get,
      url: url,
      timeout: nil,
      headers: {
        Accept: 'application/json',
        timeout: nil
      }
    ) do |response, request, result, &block|
      {
        updated_at: Time.zone.now,
        code: response.code,
        headers: response.headers,
        body: response.body.force_encoding('utf-8')
      }
    end
  end

end
