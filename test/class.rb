assert("Class#_attribute__assignment_restriction") do

  a = Class.new

  a._attribute__assignment_restriction = 2
  String._attribute__assignment_restriction = 3
  Integer._attribute__assignment_restriction = 4
  assert_equal(2, a._attribute__assignment_restriction)
  assert_equal(3, String._attribute__assignment_restriction)
  assert_equal(4, Integer._attribute__assignment_restriction)

  a._attribute__assignment_restriction = nil
  String._attribute__assignment_restriction = nil
  Integer._attribute__assignment_restriction = nil
  assert_equal(nil, a._attribute__assignment_restriction)
  assert_equal(nil, String._attribute__assignment_restriction)
  assert_equal(nil, Integer._attribute__assignment_restriction)

end
