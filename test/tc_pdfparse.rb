require 'test_helper'

class TC_PdfParse < Minitest::Test
  def setup
    @data = 
      %w{ 
          test/dataset/empty.pdf
          test/dataset/calc.pdf 
          test/dataset/crypto.pdf
      }

      @dict = StringScanner.new "<</N 2 0 R/x1 null/Pi 3.14 /a <<>>>>"

    @bytestring = StringScanner.new "(\\122\\125by\\n)"
    @hexastring = StringScanner.new "<52  55  62 79 0A>"
    @true = StringScanner.new "true"
    @false = StringScanner.new "false"
    @real = StringScanner.new "-3.141592653"
    @int = StringScanner.new "00000000002000000000000"
    @name = StringScanner.new "/#52#55#62#79#0A"
  end

  # def teardown
  # end

  def test_parsepdf
    @data.each { |file|
      PDF.read(file, :ignore_errors => false, :verbosity => Parser::VERBOSE_QUIET)
    }
  end

  def test_parsedictionary

    dict = nil
    dict = Dictionary.parse(@dict)

    assert dict[:Pi] == 3.14
    assert dict[:a].is_a?(Dictionary)

  end

  def test_parsestring
    str = nil
    str = ByteString.parse(@bytestring)

    assert str.value == "RUby\n"
    str = HexaString.parse(@hexastring)

    assert str.value == "RUby\n"
  end

  def test_parsebool
    _true, _false = nil
    _true = Boolean.parse(@true)
    _false = Boolean.parse(@false)

    assert _false.false?
    assert (not _true.false?)
  end

  def test_parsereal
    real = nil
    real = Real.parse(@real)

    assert_equal real, -3.141592653
  end

  def test_parseint
    int = nil
    int = Origami::Integer.parse(@int)

    assert_equal int, 2000000000000
  end

  def test_parsename
    name = nil
    name = Name.parse(@name)

    assert_equal name.value, :"RUby\n"
  end
end
