# frozen_string_literal: true

require_relative 'test_helper'

class ArrayGeneratorTest < Minitest::Test
  def test_count_is_correct_with_string_item
    args = { "count" => 5, "items" => { "$type" => "string", "length" => 6 } }
    gen = JsonGenerator::ArrayGenerator.new(args)

    result = gen.generate

    assert result.count == 5
    assert result.is_a? Array
    assert result[0].is_a? String
  end

  def test_count_is_zero_minimal_args
    args = { "count" => 0 }
    gen = JsonGenerator::ArrayGenerator.new(args)

    result = gen.generate

    assert result.count == 0
    assert result.is_a? Array
  end

  def test_count_is_zero_maximal_args
    args = { "count" => 0, "items" => { "$type" => "string", "length" => 6 } }
    gen = JsonGenerator::ArrayGenerator.new(args)

    result = gen.generate

    assert result.count == 0
    assert result.is_a? Array
  end
end
