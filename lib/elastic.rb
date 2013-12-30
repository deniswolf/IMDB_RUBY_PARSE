require 'elasticsearch'
require 'tempfile'
require './lib/parse'

module IMDB_RUBY_PARSE
  module ELASTIC
    ELASTIC_CLIENT = Elasticsearch::Client.new log: true
    INDEX = 'imdb'

    def self.add(type,body)
      ELASTIC_CLIENT.index index: INDEX,
                    type:  type,
                    body: body

    end

    def self.bulk_load(type, from_file)
      temp_file = Tempfile.new("#{type}.json")
      File.readlines(from_file).each_with_index do |line, index|
        # ignore file headers
        next if index < 16
        if IMDB_RUBY_PARSE::PARSE.is_parsable?(line)
          payload = IMDB_RUBY_PARSE::PARSE.to_h(line).to_json
          temp_file.write("{ index:  { _index: \"#{INDEX}\", _type: \"#{type}\"}\n#{payload}\n")
        end

      end
      temp_file.rewind

      system("curl -s -XPOST localhost:9200/_bulk --data-binary @#{temp_file.path}")

      temp_file.close
      temp_file.unlink

    end
  end
end