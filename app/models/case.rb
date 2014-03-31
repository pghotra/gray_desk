class Case < DeskApiBase

  ENDPOINT = "api/v2/cases"

  def self.endpoint_url
    [HOST, ENDPOINT].join("/")
  end

  def self.all
    ActiveSupport::JSON.decode get(endpoint_url)
  end
end
