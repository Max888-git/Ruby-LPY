require 'fileutils'

class FileWriter
    def initialize(mode, *args)
      @answers_dir = args[0]
      @filename = args[1]
      @mode = mode
    end
  
    def write(message)
      File.open(prepare_filename, 'w') do |file|
        file.puts message
      end
    end
  
    def prepare_filename
      File.join(@answers_dir, @filename)
    end
end
  