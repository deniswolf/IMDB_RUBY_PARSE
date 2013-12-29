require 'fileutils'

module IMDB_RUBY_PARSE
  module PARSE
    def self.to_h(string)
      return nil unless is_parsable?(string)
      {
          title: title(string),
          year: year(string)
      }
    end

    private

    def self.is_parsable?(string)
      /^[^\s]/ =~ string
    end

    #TODO: fix expression to avoid [1]
    def self.year(string)
      year_matches = /(?!^"[^"]+")\(([\d]+)\)/.match(string)
      year_matches ? year_matches[1].to_s : nil
    end

    def self.title(string)
      first_char = string[0]
      case first_char
        when '"'
          /^"[^"]+"/.match(string).to_s
        when /[^\s]/
          /^[^\s][^(]+/.match(string).to_s
        else
          nil
      end
    end

  end
end