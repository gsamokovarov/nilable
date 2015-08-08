require 'nilable/kernel'

# Nilable object is a tool to handle nil invocations.
#
# Any Nilable object wraps a single value object and proxy method
# invocations to it. In turn, every method result is wrapped in an Nilable
# object.
#
# That way, if somewhere along the call chain, method result is `nil`, no
# `NoMethodError` will be raised. It acts as a black hole object.
class Nilable < BasicObject
  attr_reader :value

  def initialize(object)
    @value = object.is_a?(::Nilable) ? object.value : object
  end

  def method_missing(name, *args, &block)
    if value
      ::Nilable.new(value.public_send(name, *args, &block))
    else
      self
    end
  end
end
