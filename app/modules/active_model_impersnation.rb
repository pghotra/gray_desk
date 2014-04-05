module ActiveModelImpersnation
  def persisted?
    if self.respond_to?(:id)
      self.id.present?
    else
      raise NoMethodError.new("including class must define id")
    end
  end

  def new_record?
    !persisted?
  end
end
