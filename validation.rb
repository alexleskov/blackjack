module Validation
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :validations

    TYPES = %i[presence format type].freeze

    def validate(attribute, validation_type, option = nil)
      @attributes = { name: attribute.to_sym, type: validation_type.to_sym,
                      option: option }
      check_validate_attribute
      @validations ||= []
      @validations << @attributes
    end

    protected

    def check_validate_attribute
      unless TYPES.include?(@attributes[:type])
        raise "Типа валидации \"#{@attributes[:type]}\" - не существует"
      end
      if @attributes[:type] == :format && !@attributes[:option].is_a?(Regexp)
        raise 'Опция для проверки формата должна иметь класс Regexp'
      end
      if @attributes[:type] == :type && !@attributes[:option].is_a?(Class)
        raise 'Опция для проверки типа должна являться классом'
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError => e
      puts e.inspect
      false
    end

    def validate!
      object = self

      raise "ValidationError: Rules not exist on #{object}}" if object.class.validations.nil?

      object.class.validations.each do |attributes|
        validate_method = 'validate_' + attributes[:type].to_s
        option = attributes[:option]
        begin
          instance_attribute = object.send(attributes[:name])
        rescue StandardError
          raise "ValidationError: \"#{instance_attribute}\" don't exist in \"#{object}\""
        end
        object.send(validate_method, instance_attribute, option)
      end
    end

    protected

    def validate_presence(instance_attribute, _option)
      if instance_attribute.nil? || instance_attribute.to_s.empty?
        raise "ValidationError: \"#{instance_attribute}\" is nil or empty string in \"#{self}\""
      end
    end

    def validate_format(instance_attribute, option)
      if instance_attribute !~ option
        raise "ValidationError: \"#{instance_attribute}\"
               don't match Regexp \"#{option}\" in \"#{self}\""
      end
    end

    def validate_type(instance_attribute, option)
      unless instance_attribute.is_a?(option)
        raise "ValidationError: \"#{instance_attribute}\" class
               is not a \"#{option}\" in \"#{self}\""
      end
    end
  end
end
