# frozen_string_literal: true

require_relative 'test_helper'

class StringGeneratorTestsTest < Minitest::Test
  def test_length_is_correct
    gen = JsonGenerator::StringGenerator.new({"length" => 10})
    result = gen.generate
    assert result.length == 10
  end

  def test_length_of_zero
    gen = JsonGenerator::StringGenerator.new({"length" => 0})
    result = gen.generate
    assert result.length == 0
    assert result.is_a?(String)
    assert result.empty?
  end

  def test_raises_on_unknown_type
    assert_raises KeyError do
      gen = JsonGenerator::StringGenerator.new({"NoLength" => 10})
    end
  end
end
