require_relative 'get_title_and_rename.rb'
require 'minitest/autorun'

# tests
class TestSanitize < MiniTest::Unit::TestCase
  def test_iyc_get_title
    assert_equal 'The History Of The Decline And Fall Of The Roman Empire', 'Title: The History Of The Decline And Fall Of The Roman Empire'.iyc_get_title, 'test case 1'
    assert_equal 'Les Miserables', 'Title: Les Miserables'.iyc_get_title, 'test case 2'
  end
  def test_iyc_title_to_filename
    assert_equal 'some_strange_characters', 'Title: some; strange: characters!'.iyc_get_title.iyc_title_to_filename, 'test case 3'
  end
end
