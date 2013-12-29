require 'rake'
require 'net/ftp'
require 'fileutils'
require 'zlib'

# list of files to process
#imdb_files = ['movies.list', 'movie-links.list']
imdb_files = ['movie-links.list']
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
    puts ungzip!(File.join(local_dir_name, archive_name), File.join(local_dir_name, file))
  end
end

def ungzip!(path, extract_path)
  File.open path, 'r:ISO-8859-1' do |input_file|
    content = Zlib::GzipReader.new(input_file, encoding:'ISO-8859-1')
    File.open extract_path, 'w:ISO-8859-1' do |output_file|
      output_file.print content.read
    end
    content.close
  end


end