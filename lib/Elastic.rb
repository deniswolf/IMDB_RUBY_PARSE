require 'elasticsearch'

module IMDB_RUBY_PARSE
  module ELASTIC
    ELASTIC_CLIENT = Elasticsearch::Client.new log: true

    def self.add(type,body)
      ELASTIC_CLIENT.index index: 'imdb',
                    type:  type,
                    body: body

    end

    #def self.search(type: nil, title: nil)
    #  ELASTIC_CLIENT.search index: 'imdb',
    #                        type: type,
    #                        body: { query: {
    #                            match: { title: title }
    #                        } }
    #  end
    #
    #def self.suggest(type: nil, title: nil)
    #  title = 'Nya'
    #  type = 'title'
    #  ELASTIC_CLIENT.search index: 'imdb',
    #                        type: type,
    #                        suggest_field: 'title',
    #                        suggest_text: title
    #
    #end
  end
end