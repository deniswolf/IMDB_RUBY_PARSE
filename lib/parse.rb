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
      /^"/ =~ string || /^[a-z-Z]]/ =~ string
    end

    #TODO: fix expression to avoid [1]
    def self.year(string)
      year_matches = /(?!^"[^"]+")\(([\d]+)\)/.match(string)
      year_matches ? year_matches[1].to_s : nil
    end

    def self.title(string)
      /^"[^"]+"/.match(string).to_s
    end

  end
end