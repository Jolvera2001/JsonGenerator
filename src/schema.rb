# frozen_string_literal: true
module JsonGenerator
  class SchemaGenerator
    def self.from_descriptor(descriptor)
      type_name = descriptor.fetch("$type")
      klass = REGISTRY.fetch(type_name) { raise "Unknown schema type: #{type_name}" }
      klass.new(descriptor)
    end

    def generate
      raise NotImplementedError
    end
  end

  class IntegerGenerator < SchemaGenerator
    attr_reader :max, :min

    def initialize(descriptor)
      @max = descriptor.fetch("max")
      @min = descriptor.fetch("min")
    end

    def generate
      rand(@min..@max)
    end
  end

  class StringGenerator < SchemaGenerator
    attr_reader :length

    def initialize(descriptor)
      @length = descriptor.fetch("length")
    end

    def generate
      Array.new(@length) { (('a'..'z').to_a).sample }.join
    end
  end

  class ArrayGenerator < SchemaGenerator
    attr_reader :count

    def initialize(descriptor)
      @count = descriptor.fetch("count")
      @item_gen = SchemaGenerator.from_descriptor(descriptor.fetch("items")) if @count > 0
    end

    def generate
      if @count == 0
        Array.new(0)
      else
        Array.new(@count) { @item_gen.generate }
      end
    end
  end

  class ObjectGenerator < SchemaGenerator
    def initialize(descriptor)
      @properties = descriptor.fetch("properties").transform_values { |v| SchemaGenerator.from_descriptor(v) }
    end

    def generate
      @properties.transform_values(&:generate)
    end
  end

  SchemaGenerator::REGISTRY = {
    "integer" => IntegerGenerator,
    "string" => StringGenerator,
    "boolean" => Class.new(SchemaGenerator) {
      def initialize(descriptor)
        ;
      end

      def generate = [true, false].sample },
    "array" => ArrayGenerator,
    "object" => ObjectGenerator,
  }
end