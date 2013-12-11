require 'test_helper'
require 'stringio'

class TC_PdfAttach < Minitest::Test
  def setup
    @target = PDF.new
    @attachment = "test/dataset/test.dummycrt"
    @output = StringIO.new
  end

  # def teardown
  # end

  def test_attachfile
    fspec = @target.attach_file(@attachment, :EmbeddedName => "foo.bar")
    @target.save(@output)
  end

end
