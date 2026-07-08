# frozen_string_literal: true
require 'json'
require 'fileutils'
require_relative 'schema'
module JsonGenerator

  class App
    def self.start
      json_file = ARGV[0]
      output_file = ARGV[1]

      puts "File name is #{json_file}"
      full_path = File.join(Dir.pwd, json_file)

      schema = JSON.parse(File.read(full_path))

      puts "Generating new JSON based on Schema"
      result = schema.transform_values { |desc| SchemaGenerator.from_descriptor(desc).generate }
      puts JSON.pretty_generate(result)

      output_location = File.join(Dir.pwd, output_file)
      FileUtils.mkdir_p(File.dirname(output_location))
      File.write(output_location, JSON.pretty_generate(result))
    end
  end
end
