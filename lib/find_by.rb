class Module

  def create_finder_methods(*attributes)
    class_eval do
      attributes.each do |attribute|
        send(:define_method, "find_by_#{attribute}"){|arg| find_by(attribute.to_sym => arg) }
      end
    end
  end

end
