class Case < DeskApiBase

  ENDPOINT = "api/v2/cases"

  def self.all
    get(ENDPOINT, CaseParser)
  end
end
