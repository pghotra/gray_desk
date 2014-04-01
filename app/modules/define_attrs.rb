module DefineAttrs
  def define_accessors(attrs)
    [*attrs].each do |attr|
      attr_accessor attr
    end

    class_eval %{
      def attributes
        #{attrs}
      end
    }
  end
end
