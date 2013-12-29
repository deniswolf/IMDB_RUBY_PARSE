require 'rake'
require './lib/download'
require './lib/unpack'

# list of files to process
#imdb_files = ['movies.list', 'movie-links.list']
imdb_files = ['aka-titles.list']
# default folder to store downloaded files
local_dir_name = File.path('./files/')

desc "Download Interfaces files from IMDB site"
task :download do
  IMDB_RUBY_PARSE::DOWNLOAD.get_files!(imdb_files, local_dir_name)
end

desc "Unpack downloaded archives"
task :unpack do
  IMDB_RUBY_PARSE::UNPACK.unpack!(imdb_files, local_dir_name)
end

