require 'test_helper'
require 'stringio'

class TC_PdfNew < Minitest::Test
  def setup
    @output = StringIO.new
  end

  # def teardown
  # end

  def test_pdf_struct

    pdf = PDF.new

    null = Null.new
    pdf << null
    pdf.save(@output)

    assert null.is_indirect?
    assert pdf.objects.include?(null)
    assert_equal pdf.revisions.first.body[null.reference], null
    assert_equal null.reference.solve, null
  end

end
