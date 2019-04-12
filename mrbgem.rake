MRuby::Gem::Specification.new('mruby-attribute') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Rob Fors'
  spec.version = '0.0.0'
  spec.summary = 'assign attributes to some core objects'

  spec.rbfiles = Dir.glob("#{dir}/mrblib/*.rb")
  spec.add_dependency('mruby-metaprog', core: 'mruby-metaprog')
end
