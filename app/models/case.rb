class Case
  API_KEY = "1DxoqIvYIBRYm3Xa1DsA"
  API_KEY_SECRET = "tnWWpcZkCnTbP75tq5pOg0GyQe9yZIssU4w4ZygB"
  ACCESS_TOKEN = "85UvBtuRJ4ZZDH1x6oQj"
  ACCESS_TOKEN_SECRET = "n7PwWGcEkeI9fLU31CbAiwM4pNv4lKqc5x8F9VEx"

  HOST = "https://gray.desk.com"
  ENDPOINT = "api/v2/cases"

  def self.endpoint_url
    [HOST, ENDPOINT].join("/")
  end

  def self.access_token
    consumer = OAuth::Consumer.new(API_KEY, API_KEY_SECRET, site: HOST)

    OAuth::AccessToken.from_hash(
      consumer,
      oauth_token: ACCESS_TOKEN,
      oauth_token_secret: ACCESS_TOKEN_SECRET
    )
  end

  def self.all
    ActiveSupport::JSON.decode(access_token.get(endpoint_url).body)
  end
end
