class Label < DeskApiBase
  extend DefineAttrs
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  define_accessors [:name, :types, :color, :enabled, :description, :position]

  ENDPOINT = "api/v2/labels"

  def initialize
  end

  def self.all
    get(ENDPOINT, EmbeddedEntriesParser)
  end

  def create(attrs={})
    post(ENDPOINT, attrs)
  end
  alias :save :create

  def persisted?
    self.position.present?
  end

  def new_record?
    !persisted?
  end
end
