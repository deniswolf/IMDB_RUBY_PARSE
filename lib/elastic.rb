require 'elasticsearch'
require 'tempfile'
require './lib/record'

module IMDB_RUBY_PARSE
  module ELASTIC
    ELASTIC_CLIENT = Elasticsearch::Client.new log: true
    INDEX = 'imdb'

    def self.bulk_load(type, from_file)
      temp_file = Tempfile.new("#{type}.json")
      File.readlines(from_file).each_with_index do |line, index|
        # ignore file headers
        next if index < 16
        payload = Record.new(line)
        if payload.is_parsable?
          temp_file.write("{ index:  { _index: \"#{INDEX}\", _type: \"#{type}\"}\n#{payload.to_h.to_json}\n")
        end

      end
      temp_file.rewind

      system("curl -s -XPOST localhost:9200/_bulk --data-binary @#{temp_file.path}")

      temp_file.close
      temp_file.unlink

    end
  end
end