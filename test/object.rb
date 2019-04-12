assert("Object#_attribute__get_attribute") do

  # instance variable strategy
  c = Class.new
  i1 = c.new
  i2 = c.new
  # not set yet
  assert_equal(nil, i1._attribute__get_attribute('a'))
  i1._attribute__set_attribute('a', :v)
  # we expect to rely on the instance variable strategy for this type of object
  assert_equal(nil, i1.class._attribute__assignment_restriction)
  r = i1._attribute__get_attribute('a')
  # check return value
  assert_same(i1.instance_variable_get(:@a), r)

  # singleton method strategy
  a = []
  # not set yet
  assert_equal(nil, a._attribute__get_attribute('a'))
  a._attribute__set_attribute('a', :v)
  # we expect to rely on the singleton method strategy for this type of object
  assert_equal(:singleton_method, a.class._attribute__assignment_restriction)
  r = a._attribute__get_attribute('a')
  # check return value
  assert_equal(:v, r)

  # no strategy
  n = 1
  n._attribute__set_attribute('a', :v)
  # we expect to not have a strategy for this type of object
  assert_equal(:unavailable, n.class._attribute__assignment_restriction)
  # check return value
  assert_equal(nil, n._attribute__get_attribute('a'))

end


assert("Object#_attribute__set_attribute") do

  # instance variable strategy
  c = Class.new
  i1 = c.new
  i2 = c.new
  r = i1._attribute__set_attribute('a', :v)
  # we expect to rely on the instance variable strategy for this type of object
  assert_equal(nil, i1.class._attribute__assignment_restriction)
  # check iv has been set
  assert_true(i1.instance_variables.include?(:@a))
  assert_equal(:v, i1.instance_variable_get(:@a))
  # check return value
  assert_equal(true, r)
  # should not share attribute with other instance of the same class
  assert_equal(nil, i2.instance_variable_get(:@a))
  # should not assign an iv if the value is nil
  assert_equal(true, i1._attribute__set_attribute('a', nil))
  assert_false(i1.instance_variables.include?(:@a))

  # singleton method strategy
  a1 = []
  a2 = []
  r = a1._attribute__set_attribute('a', :v)
  # we expect to rely on the singleton method strategy for this type of object
  assert_equal(:singleton_method, a1.class._attribute__assignment_restriction)
  assert_true(a1.respond_to?(:a))
  assert_equal(:v, a1.a)
  # check return value
  assert_equal(true, r)
  # should not have the same singleton method as another instance of the same class
  assert_false(a2.respond_to?(:a))
  a2._attribute__set_attribute('a', :vv)
  assert_equal(:v, a1.a) # should still be the same
  assert_equal(:vv, a2.a)
  # replace a value
  a1._attribute__set_attribute('a', :vvv)
  assert_equal(:vvv, a1.a)
  # should not define a method if the value is nil
  a1._attribute__set_attribute('a', nil)
  assert_false(a1.respond_to?(:a))

  # no strategy
  n = 1
  assert_equal(false, n._attribute__set_attribute('a', :v))
  # we expect to not have a strategy for this type of object
  assert_equal(:unavailable, n.class._attribute__assignment_restriction)

end
