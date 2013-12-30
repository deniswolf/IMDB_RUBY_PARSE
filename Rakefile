require 'rake'
require 'json'
require './lib/imdb_ruby_parse'

# list of files to process
imdb_files = ['movies.list', 'movie-links.list', 'aka-titles.list']

# default folder to store downloaded files
local_dir_name = File.path('./files/')

namespace :import do
  desc "Download Interfaces files from IMDB site"
  task :download do
    IMDB_RUBY_PARSE.get_files!(imdb_files, local_dir_name)
  end

  desc "Unpack downloaded archives"
  task :unpack do
    IMDB_RUBY_PARSE.unpack!(imdb_files, local_dir_name)
  end
end

namespace :export do
  desc "Export records to Elasticsearch"
  namespace :elastic do
    desc "Export Titles to Elasticsearch"
    task :titles do
      IMDB_RUBY_PARSE::ELASTIC.bulk_load('title',File.join(local_dir_name, 'aka-titles.list'))
    end
  end

end
