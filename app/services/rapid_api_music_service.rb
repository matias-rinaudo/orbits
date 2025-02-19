class RapidApiMusicService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    result = RapidApiMusic.call(keyword: @keyword)

    raise StandardError, result.error unless result.success?

    result.data
  end
end
