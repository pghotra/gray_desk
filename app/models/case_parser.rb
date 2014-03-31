class CaseParser
  def self.from_json(json)
    [].tap do |cases|
      entries(json).each do |entry|
        cases << entry
      end
    end
  end

  private

  def self.entries(json)
    json.fetch("_embedded", {}).fetch("entries", [])
  end
end
