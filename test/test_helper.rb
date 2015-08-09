$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'minitest/autorun'
require 'nilable'

class BaseTest < MiniTest::Test
  def self.test(name, &block)
    define_method("test_#{name}", &block)
  end
end
