# Get and set attributes to objects.
module Attribute

  # Build a name with a unique prefix.
  # Use these names to ensure a name collision will never occur with existing instance variables
  # or methods.
  # Will also do some type checking to ensure the name can be used for an attribute.
  # @api private
  # @param name [String,Symbol]
  # @return [String]
  def self.full_name(name)
    raise TypeError, "'name' must be a String or Symbol" unless name.is_a?(String) || name.is_a?(Symbol)
    "_attribute__#{name.to_s}"
  end

  # Get an attribute of an object.
  # @param object [Object]
  # @param name [String,Symbol]
  # @return [nil,Object] the attribute or +nil+ if it does not exist
  def self.get(object, name)
    object._attribute__get_attribute(full_name(name))
  end

  # Set an attribute of an object.
  # @param object [Object]
  # @param name [String,Symbol]
  # @param value [Object]
  # @return [Boolean] if assignment was possible
  def self.set(object, name, value)
    object._attribute__set_attribute(full_name(name), value)
  end

end
