require 'helper'

class TestOsxtrash < Test::Unit::TestCase

  def test_new
    assert OSXTrash.new
  end

  def test_list
    items = OSXTrash.new.list
    assert items
  end


end
