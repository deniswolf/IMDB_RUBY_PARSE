module IMDB_RUBY_PARSE
  class Record
    def initialize(string)
      @string = string
    end

    def to_h
      return nil unless is_parsable?
      {
          title: title(@string),
          year: year(@string)
      }
    end

    def is_parsable?
      /^[^\s\-]/ =~ @string
    end

    private

    #TODO: fix expression to avoid [1]
    def year(string)
      year_matches = /(?!^"[^"]+")\(([\d]+)\)/.match(string)
      year_matches ? year_matches[1].to_s : nil
    end

    def title(string)
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