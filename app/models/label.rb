class Label < DeskApiBase
  extend DefineAttrs
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  define_accessors [:name, :types, :color, :enabled, :description, :id]

  ENDPOINT = "api/v2/labels"

  def initialize(attrs={})
    set_attributes(attrs)
  end

  def self.all
    get(ENDPOINT, EmbeddedEntriesParser)
  end

  def self.create(attrs={})
     new post(ENDPOINT, attrs)
  end

  def persisted?
    self.id.present?
  end

  def new_record?
    !persisted?
  end

  def user_controlled_attrs
    attributes - [:id, :enabled]
  end

  private

  def set_attributes(attrs)
    attrs.each_pair do |key, value|
      if self.respond_to?(attribute = "#{key}=".to_sym)
        self.send(attribute, value)
      end
    end
  end

end
