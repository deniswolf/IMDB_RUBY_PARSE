require 'fileutils'
require 'zlib'

module IMDB_RUBY_PARSE
    def self.unpack!(filenames, local_dir_name)
      filenames.each do |file|
        archive_name = file+'.gz'
        archive_path = File.join(local_dir_name, archive_name)
        extracted_path = File.join(local_dir_name, file)
        ungzip!(archive_path)
        fix_encoding!(extracted_path)
      end
    end

    private

    def self.ungzip!(path)
      system('gunzip',path)
    end

    # IMDB stores everything in Latin1 while everyone loves UTF-8
    def self.fix_encoding!(path)
      # make sure we have temp dir for re-encoding
      FileUtils.mkdir_p('./tmp')

      system("iconv -f iso-8859-1 -t utf-8 #{path} > ./tmp/inconv_temp")
      system("mv ./tmp/inconv_temp #{path}")
    end
end