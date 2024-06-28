module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def inherited(subclass)
      super
      subclass.instance_variable_set(:@validations, validations.dup)
    end

    def validate(attr_name, validation_type, param = nil, message = nil)
      @validations ||= []
      @validations << { attr_name: attr_name, validation_type: validation_type, param: param, message: message }
      puts 'Массив инициализирован'
      puts @validations.inspect
    end

    def validations
      @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr_value = instance_variable_get("@#{validation[:attr_name]}")
        send("validate_#{validation[:validation_type]}", attr_value, validation[:param], validation[:message])
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(value, _param, message)
      raise(message || 'Значение не может быть пустым или nil') if value.nil? || value.to_s.empty?
    end

    def validate_format(value, format, message)
      raise(message || 'Значение не соответствует формату') unless value =~ format
    end

    def validate_type(value, type, message)
      raise(message || "Значение должно быть типа #{type}") unless value.is_a?(type)
    end
  end
end
