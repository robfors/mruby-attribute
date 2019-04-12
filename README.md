# mruby-attribute
An _mruby_ gem that was make to get around some limitations of _mruby_. It allows assigning attributes to instances of some of the core objects that may not otherwise support an assignment. It will attempt to use an instance variable then regress to a singleton method if available. The main purpose of this gem is that it will dynamically find and automaticity use the best strategy.

## Example

Make an `Object` hold an attribute. This is simple, it will just set an instance variable.
```ruby
obj = Object.new
value = Object.new
# attribute names are internally prefixed to avoid name collision with
#   native instance variables and methods, however you should prefix them
#   as well to avoid a collision with other code using this gem
Attribute.set(obj, :_my_gem__obj, value) #=> true
obj.instance_variable_get(:@_attribute___my_gem__obj) #=> value
Attribute.get(obj, :_my_gem__obj) #=> value
```

Make an `Array` hold an attribute This is harder, as you can not set any instance variables on that object, so it will define a singleton method instead.
```ruby
obj =[]
value = Object.new
Attribute.set(obj, :_my_gem__obj, value) #=> true
obj._attribute___my_gem__obj #=> value
Attribute.get(obj, :_my_gem__obj) #=> value
```

Make an `Integer` hold an attribute. Not possible, the return value of `false` indicates that the assignment failed.
```ruby
obj = 1
value = Object.new
Attribute.set(obj, :_my_gem__obj, value) #=> false
Attribute.get(obj, :_my_gem__obj) #=> nil
```