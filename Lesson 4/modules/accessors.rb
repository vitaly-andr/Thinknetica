# frozen_string_literal: true
module Accessors

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        attr_name = attr.to_s
        var_name = "@#{attr_name}".to_sym
        history_var = "@#{attr_name}_history".to_sym

        define_getter(attr_name, var_name)
        define_setter_with_history(attr_name, var_name, history_var)
        define_history_method(attr_name, history_var)
      end
    end

    def strong_attr_accessor(attr, attr_class)
      attr_name = attr.to_s
      var_name = "@#{attr_name}".to_sym

      # Геттер для атрибута
      define_method(attr_name) do
        instance_variable_get(var_name)
      end

      # Сеттер для атрибута с проверкой типа
      define_method("#{attr_name}=") do |value|
        raise TypeError, "Expected instance of #{attr_class}, got #{value.class}" unless value.is_a?(attr_class)

        instance_variable_set(var_name, value)
      end
    end

    private

    def define_getter(attr_name, var_name)
      define_method(attr_name) do
        instance_variable_get(var_name)
      end
    end

    def define_setter_with_history(attr_name, var_name, history_var)
      define_method("#{attr_name}=") do |value|
        history = instance_variable_get(history_var) || []
        history << instance_variable_get(var_name) unless instance_variable_get(var_name).nil?
        instance_variable_set(history_var, history)
        instance_variable_set(var_name, value)
      end
    end

    def define_history_method(attr_name, history_var)
      define_method("#{attr_name}_history") do
        instance_variable_get(history_var) || []
      end
    end
  end

end
