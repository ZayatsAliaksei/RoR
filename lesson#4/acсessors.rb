# frozen_string_literal: true

module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      name_history = "@#{name}_history"
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(name_history) }

      define_method("#{name}=") do |value|
        if instance_variable_get(name_history).nil?
          instance_variable_set(name_history, [instance_variable_get(var_name)])
        else
          instance_variable_get(name_history) << instance_variable_get(var_name)
        end
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_acessor(name, type)
    name = "@#{name}"
    define_method(name) { instance_variable_get(name) }
    define_method("@#{name}=") do |value|
      if val.instance_of?(type)
        instance_variable_set(name, value)
      else
        raise TypeError
      end
    end
  end
end
