require 'test_helper'
require 'stringio'

class TC_Pages < Minitest::Test
  def setup
    @target = PDF.new
    @output = StringIO.new
  end

  # def teardown
  # end

  def test_appendpage
    p1, p2, p3 = Page.new, Page.new, Page.new

    @target.append_page p1, p2, p3

    assert_equal @target.pages.size, 3

    assert_equal @target.pages[0], p1
    assert_equal @target.pages[1], p2
    assert_equal @target.pages[2], p3

    assert_equal @target.Catalog.Pages, p1.Parent
    assert_equal @target.Catalog.Pages, p2.Parent
    assert_equal @target.Catalog.Pages, p3.Parent

    @target.save(@output)

    assert_equal @target.Catalog.Pages.Count, 3
  end

end
