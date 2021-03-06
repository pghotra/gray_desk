class Case < DeskApiBase
  extend DefineAttrs
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModelImpersnation

  define_accessors [:subject, :status, :type, :priority, :labels, :label_action, :id]

  ENDPOINT = "api/v2/cases"

  def initialize(attrs={})
    set_attributes(attrs)
  end

  def self.all
    translate_to_cases get(ENDPOINT, EmbeddedEntriesParser)
  end

  def self.find_by_id(id)
    response = get([ENDPOINT, id].join("/"), SingularResourceParser)
    translate_to_cases([response]).try(:first)
  end

  def self.update(id, attrs={})
     response = put([ENDPOINT, id].join("/"), attrs)
     new(response)
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
