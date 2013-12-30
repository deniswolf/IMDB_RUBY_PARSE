require 'rake'
require 'json'
require './lib/download'
require './lib/unpack'
require './lib/parse'
require './lib/Elastic'

# list of files to process
#imdb_files = ['movies.list', 'movie-links.list']
imdb_files = ['aka-titles.list']
# default folder to store downloaded files
local_dir_name = File.path('./files/')

namespace :import do
  desc "Download Interfaces files from IMDB site"
  task :download do
    IMDB_RUBY_PARSE::DOWNLOAD.get_files!(imdb_files, local_dir_name)
  end

  desc "Unpack downloaded archives"
  task :unpack do
    IMDB_RUBY_PARSE::UNPACK.unpack!(imdb_files, local_dir_name)
  end
end

namespace :parse do
  desc "Extract list of titles as {title:'', year:''}"
  task :titles do
    File.readlines(File.join(local_dir_name, 'aka-titles.list')).each_with_index do |line, index|
      # ignore file headers
      next if index < 16
      if IMDB_RUBY_PARSE::PARSE.is_parsable?(line)
        puts IMDB_RUBY_PARSE::PARSE.to_h(line).to_json
      end
    end
  end
end

namespace :export do
  desc "Export records to Elasticsearch"
  namespace :elastic do
    desc "Export Titles to Elasticsearch"
    task :titles do
      File.readlines(File.join(local_dir_name, 'aka-titles.list')).each_with_index do |line, index|
        # ignore file headers
        next if index < 16
        #break if index > 1000
        if IMDB_RUBY_PARSE::PARSE.is_parsable?(line)
          record =  IMDB_RUBY_PARSE::PARSE.to_h(line)
          #puts "are going to add #{record}"
          IMDB_RUBY_PARSE::ELASTIC.add('title', record)
        end
      end
    end
  end

end
