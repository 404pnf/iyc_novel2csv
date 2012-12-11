require 'minitest/autorun'
require_relative 'remove_linefeed_in_paragraph.rb'

# tests
UNFORMATED = "111111\n111111\n\n\n   22222\n   22222\n\n\n\n111111\n111111"
FORMATED   = "111111 111111\n\n   22222\n   22222\n\n111111 111111"
class TestSanitize < MiniTest::Unit::TestCase
  def test_remove_line_feed
    assert_equal "111 111\n\n111 111", "111\n111\n\n\n111\n111".remove_line_feed, 'join lines'
    assert_equal "111 111\n\n111 111\n\n222 222 ", "111\n111\n\n\n111\n111\n\n\n222\n222\n".remove_line_feed, 'two, paragraphs, join lines'
    assert_equal " 222\n 222\n 222", " 222\n 222\n 222".remove_line_feed, 'do not join lines pre lines'
    assert_equal " 222\n 222\n\n 222\n 222", " 222\n 222\n\n\n\n\n 222\n 222".remove_line_feed, 'two parts, do not join lines pre lines'
    assert_equal FORMATED, UNFORMATED.remove_line_feed, 'mix paragraph and pre'
  end
end
