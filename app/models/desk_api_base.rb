class DeskApiBase
  extend DefineAttrs

  API_KEY = "1DxoqIvYIBRYm3Xa1DsA"
  API_KEY_SECRET = "tnWWpcZkCnTbP75tq5pOg0GyQe9yZIssU4w4ZygB"
  ACCESS_TOKEN = "85UvBtuRJ4ZZDH1x6oQj"
  ACCESS_TOKEN_SECRET = "n7PwWGcEkeI9fLU31CbAiwM4pNv4lKqc5x8F9VEx"

  HOST = "https://gray.desk.com"

  def self.access_token
    consumer = OAuth::Consumer.new(API_KEY, API_KEY_SECRET, site: HOST)

    OAuth::AccessToken.from_hash(
      consumer,
      oauth_token: ACCESS_TOKEN,
      oauth_token_secret: ACCESS_TOKEN_SECRET
    )
  end

  def self.get(path, parser)
    response = access_token.get(endpoint_url(path)).body
    parser.from_json(decode(response))
  end

  def self.post(path, data)
    serialized_data = ActiveSupport::JSON.encode(data)
    response = access_token.post(endpoint_url(path), serialized_data, post_headers)
    decode response.body
  end

  private

  def self.endpoint_url(path)
    raise BadApiEndpoint if invalid_path(path)
    [HOST, path].join("/")
  end

  def self.invalid_path(path)
    path.blank?
  end

  def self.decode(response_body)
    ActiveSupport::JSON.decode response_body
  end

  def self.post_headers
    {'Accept' => 'application/json',
     'Content-Type' => 'application/json'}
  end

  class BadApiEndpoint < RuntimeError; end
end
