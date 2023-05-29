require 'fileutils'

class FileWriter
    def initialize(answers_dir, filename)
      @answers_dir = answers_dir
      @filename = filename
    end
  
    def write(message)
      File.open(prepare_filename, 'w') do |file|
        file.puts message
      end
    end
  
    def prepare_filename
      File.join(__dir__, @answers_dir, @filename)
    end
end
  