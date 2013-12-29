require 'rake'
require 'net/ftp'
require 'fileutils'
require 'zlib'

# list of files to process
#imdb_files = ['movies.list', 'movie-links.list']
imdb_files = ['aka-titles.list']
# default folder to store downloaded files
local_dir_name = File.path('./files/')

desc "Download Interfaces files from IMDB site"
task :download do
  # create ./files if it doesn't exist
  FileUtils.mkdir_p(local_dir_name)

  # use German IMDB server by default
	ftp_url = 'ftp.fu-berlin.de'
	ftp_dir = '/pub/misc/movies/database/'


	ftp = Net::FTP.new
  ftp.connect(ftp_url)
  ftp.login
  ftp.chdir(ftp_dir)
  imdb_files.each do |file|
    archive_name = file+'.gz'
    puts "Going to download file: #{file}"
    ftp.get(archive_name, File.join(local_dir_name, archive_name))
  end
  ftp.close
end

desc "Unpack downloaded archives"
task :unpack do
  imdb_files.each do |file|
    archive_name = file+'.gz'
    archive_path = File.join(local_dir_name, archive_name)
    extracted_path = File.join(local_dir_name, file)
    ungzip!(archive_path)
    fix_encoding!(extracted_path)
  end
end

def ungzip!(path)
  system('gunzip',path)
end

# IMDB stores everything in Latin1 while everyone loves UTF-8
def fix_encoding!(path)
  # make sure we have temp dir for re-encoding
  FileUtils.mkdir_p('./tmp')

  system("iconv -f iso-8859-1 -t utf-8 #{path} > ./tmp/inconv_temp")
  system("mv ./tmp/inconv_temp #{path}")
end