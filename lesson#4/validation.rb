module Validation

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, params = nil)
      @validations ||= []
      @validations << {
        attr: name,
        law: type,
        parametr: params
      }
    end
  end

  module InstanceMethods
    def validate!
      parent = if self.class.superclass == Object
        self.class
      else
        self.class.superclass
               end
      parent.validations&.each do |validation|
        attr_value = instance_variable_get("@#{validation[:attr]}")
        send validation[:law], validation[:attr], attr_value, validation[:parametr]
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    private

    def presence(attr_name, attr_value, _unused)
      raise ArgumentError, "@#{attr_name} не может быть пустым значением в #{self.class}" if attr_value.nil? || attr_value == 0 || attr_value == ''
    end

    def format(attr_name, attr_value, pattern)
      raise ArgumentError, "@#{attr_name} укажите в верном формате при создании #{self.class}" unless attr_value =~ pattern
    end

    def type(attr_name, attr_value, valid_class)
      raise ArgumentError, "@#{attr_name} невалидный класс обьекта для #{self.class}" unless attr_value.is_a?(valid_class)
    end
  end
end
