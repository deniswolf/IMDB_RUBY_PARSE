require 'net/ftp'
require 'fileutils'

module IMDB_RUBY_PARSE
    def self.get_files!(filenames, local_dir_name)
      # create ./files if it doesn't exist
      FileUtils.mkdir_p(local_dir_name)

      # use German IMDB server by default
      ftp_url = 'ftp.fu-berlin.de'
      ftp_dir = '/pub/misc/movies/database/'


      ftp = Net::FTP.new
      ftp.connect(ftp_url)
      ftp.login
      ftp.chdir(ftp_dir)
      filenames.each do |file|
        archive_name = file+'.gz'
        puts "Going to download file: #{file}"
        ftp.get(archive_name, File.join(local_dir_name, archive_name))
      end
      ftp.close
    end
end