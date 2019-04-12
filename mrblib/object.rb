# We will try to use various strategies to assign attributes to a desired object.
# The preferred strategy is to simply set an instance variable
# but due to an mruby limitation (see: https://github.com/mruby/mruby/issues/565)
# we can not set the instance variables of built-in objects.
# The second strategy is to use a singleton method.
# After finding a valid strategy for an object, its class we will remember the strategy for the next time.
class Object

  # Get an attribute of an object.
  # @api private
  # @param name [String]
  # @return [nil,Object] the attribute or +nil+ if it does not exist
  def _attribute__get_attribute(name)
    restriction = self.class._attribute__assignment_restriction
    case restriction
    when :unavailable
      nil
    when :singleton_method
      return nil unless respond_to?(name)
      send(name)
    else # use instance variable
      instance_variable_get("@#{name}")
    end
  end

  # Set an attribute of an object.
  # @api private
  # @param name [String]
  # @param value [Object]
  # @return [Boolean] if assignment was possible
  def _attribute__set_attribute(name, value)
    restriction = self.class._attribute__assignment_restriction
    case restriction
    when :unavailable
      false
    when :singleton_method
      begin
        self.define_singleton_method(name) { value }
        if value == nil
          # we know it is assignable now leave undefined to save memory
          self.singleton_class.send(:undef_method, name)
        end
        true
      rescue TypeError
        self.class._attribute__assignment_restriction = :unavailable
        _attribute__set_attribute(name, value) #retry with new restriction
      end
    else # assume we can use an instance variable
      begin
        instance_variable_set("@#{name}", value)
        if value == nil
          # we know it is assignable now remove instance variable to save memory
          remove_instance_variable("@#{name}")
        end
        true
      rescue ArgumentError
        self.class._attribute__assignment_restriction = :singleton_method
        _attribute__set_attribute(name, value) #retry with new restriction
      end
    end
  end

end
