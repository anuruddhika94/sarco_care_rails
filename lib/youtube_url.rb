require "net/http"
require "json"

# Parses a pasted YouTube URL down to its video id, and fetches that video's
# real title via YouTube's public oEmbed endpoint (no API key needed) — used
# by Admin::ExercisesController so an exercise's name always matches its
# actual video, instead of being hand-typed and potentially wrong.
module YoutubeUrl
  ID_PATTERN = %r{
    (?:youtube\.com/(?:watch\?v=|shorts/|embed/)|youtu\.be/)
    ([A-Za-z0-9_-]{11})
  }x

  module_function

  def extract_id(input)
    return nil if input.blank?

    input = input.strip
    # Bare 11-character id, or any of the standard URL shapes.
    return input if input.match?(/\A[A-Za-z0-9_-]{11}\z/)

    match = input.match(ID_PATTERN)
    match && match[1]
  end

  def fetch_title(video_id)
    uri = URI("https://www.youtube.com/oembed")
    uri.query = URI.encode_www_form(url: "https://www.youtube.com/watch?v=#{video_id}", format: "json")

    response = Net::HTTP.get_response(uri)
    return nil unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)["title"]
  rescue StandardError
    nil
  end
end
