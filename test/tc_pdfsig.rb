require 'test_helper'
require 'stringio'

class TC_PdfSig < Minitest::Test
  def setup
    @target = PDF.read("test/dataset/calc.pdf", :ignore_errors => false, :verbosity => Parser::VERBOSE_QUIET)
    @output = StringIO.new

    @cert = OpenSSL::X509::Certificate.new(File.read("test/dataset/test.dummycrt"))
    @key = OpenSSL::PKey::RSA.new(File.read("test/dataset/test.dummykey"))
  end

  # def teardown
  # end

  def test_sig

    sigannot = Annotation::Widget::Signature.new.set_indirect(true)
    sigannot.Rect = Rectangle[:llx => 89.0, :lly => 386.0, :urx => 190.0, :ury => 353.0]

    @target.append_page(page = Page.new)
    page.add_annot(sigannot)

    @target.sign(@cert, @key, 
                 :annotation => sigannot, 
                 :location => "France", 
                 :contact => "fred@security-labs.org", 
                 :reason => "Proof of Concept"
                )

    assert @target.frozen?

    @target.save(@output)

    assert PDF.read(@output.reopen(@output.string,'r'), :verbosity => Parser::VERBOSE_QUIET).verify
  end

end
