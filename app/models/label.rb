class Label < DeskApiBase

  ENDPOINT = "api/v2/labels"

  def self.all
    get(ENDPOINT, EmbeddedEntriesParser)
  end

  def create(attrs={})
    post(ENDPOINT, attrs)
  end
end
