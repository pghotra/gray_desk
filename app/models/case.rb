class Case < DeskApiBase
  extend DefineAttrs
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  define_accessors [:subject, :status, :type, :priority, :labels, :label_action, :id]

  ENDPOINT = "api/v2/cases"

  def initialize(attrs={})
    set_attributes(attrs)
  end

  def self.all
    translate_to_cases get(ENDPOINT, EmbeddedEntriesParser)
  end

  def persisted?
    self.id.present?
  end

  def new_record?
    !persisted?
  end

  private

  def set_attributes(attrs)
    attrs.each_pair do |key, value|
      if self.respond_to?(attribute = "#{key}=".to_sym)
        self.send(attribute, value)
      end
    end
  end

  def self.translate_to_cases(json_set)
    [].tap do |case_items|
      if json_set.present?
        json_set.each do |json|
          case_items << new(json)
        end
      end
    end
  end

end
