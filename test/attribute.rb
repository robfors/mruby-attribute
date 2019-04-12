assert("Attribute#full_name") do

  assert_raise(TypeError) { Attribute.full_name(1) }

  assert_equal('_attribute__a', Attribute.full_name('a'))

  assert_equal('_attribute__a', Attribute.full_name(:a))

end


assert("Attribute#get") do

  o = Object.new
  o.instance_variable_set(:@_attribute__a, :v)
  assert_equal(:v, Attribute.get(o, :a))

end


assert("Attribute#set") do

  o = Object.new
  assert_equal(true, Attribute.set(o, :a, :v))
  assert_equal(:v, o.instance_variable_get(:@_attribute__a))

end
