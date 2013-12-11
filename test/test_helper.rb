require 'minitest/autorun'

begin
  require 'origami'
rescue LoadError
  ORIGAMIDIR = "#{File.dirname(__FILE__)}/../lib"
  $: << ORIGAMIDIR
  require 'origami'
end
include Origami
