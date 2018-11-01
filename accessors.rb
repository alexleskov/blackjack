module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        memory ||= nil
        history_of_values ||= []
        define_method("#{name}=") do |value|
          history_of_values << memory unless memory.nil?
          instance_variable_set(var_name, value)
          memory = value
        end
        define_method(name.to_s) { instance_variable_get(var_name) }
        define_method("#{name}_history") { history_of_values }
      end
      true
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name.to_s) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise "StrongAttrError: Value by \"#{name}\" is not a #{type}" unless value.is_a?(type)

        instance_variable_set(var_name, value)
      end
      true
    end
  end
end
