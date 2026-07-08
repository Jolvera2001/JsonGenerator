# frozen_string_literal: true

require_relative 'test_helper'

class IntegerGeneratorTestsTest < Minitest::Test
  def test_generates_within_range
    gen = JsonGenerator::IntegerGenerator.new({ "max" => 5, "min" => 1 })
    result = gen.generate
    assert result <= 5
    assert result >= 1
  end

  def test_raises_on_unknown_type
    assert_raises KeyError do
      JsonGenerator::IntegerGenerator.new({ "nappy" => 5, "mappy" => 1 })
    end
  end
end
