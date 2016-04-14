class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    class_eval do
      attributes.each do |attribute|
        define_method("find_by_#{attribute}") do |arg|
          find_by(attribute, arg)
        end
      end
    end
  end
end
