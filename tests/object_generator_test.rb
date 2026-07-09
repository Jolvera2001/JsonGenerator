# frozen_string_literal: true

require_relative 'test_helper'

class ObjectGeneratorTest < Minitest::Test
  def test_object_with_basic_props
    args = {
      "$type" => "object", "properties" => {
        "name" => {
          "$type" => "string",
          "length" => 50
        },
        "height" => {
          "$type" => "integer", "max" => 1000, "min" => 10
        },
        "is_alive" => {
          "$type" => "boolean",
        }
      }
    }
    gen = JsonGenerator::ObjectGenerator.new args

    result = gen.generate

    assert result.fetch("name").length == 50
    assert result.fetch("height") >= 10 && result.fetch("height") <= 1000
    assert [true, false].include? result.fetch("is_alive")
  end

  def test_object_with_array_props
    args = {
      "$type" => "object", "properties" => {
        "numbers" => {
          "$type" => "array",
          "count" => 50,
          "items" => { "$type" => "integer", "min" => 1, "max" => 10 }
        }
      }
    }
    gen = JsonGenerator::ObjectGenerator.new args

    result = gen.generate
    numbers = result.fetch("numbers")

    assert numbers.length == 50
    assert numbers.is_a? Array
    assert numbers.all? { |i| i >= 1 && i <= 10 }
  end
end
