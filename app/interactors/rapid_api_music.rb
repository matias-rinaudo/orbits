class RapidApiMusic
  include Interactor

  BASE_URL = ENV['RAPIDAPI_BASE_URL']

  def call
    response = fetch_music

    context.fail!(error: "API request failed with status #{response.status}") unless response.success?

    body = JSON.parse(response.body)
    context.data = body['music']
  rescue StandardError => e
    context.fail!(error: "API request failed: #{e.message}")
  end

  private

  def fetch_music
    Faraday.get(BASE_URL + '/search/music', query_params) do |req|
      req.headers['x-rapidapi-key'] = ENV['RAPIDAPI_KEY']
      req.headers['x-rapidapi-host'] = ENV['RAPIDAPI_HOST']
    end
  end

  def query_params
    {
      keyword: context.keyword,
      count: 10,
      offset: 0,
      region: 'GB'
    }
  end
end
