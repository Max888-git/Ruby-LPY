class FileHelper
    def write_file(filename, content)
        File.open(filename, 'w') { |file| file.write(content) }
    end

    def get_all_files_recursively(root_directory, permitted_extensions)
        files = Dir.glob("#{root_directory}/**/*").select { |e| File.file? e }

        files.select { |f| permitted_extensions.any? { |ext| ext == File.extname(f)} }
    end
end