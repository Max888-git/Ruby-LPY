require 'zip'

class Zipper
  def initialize(input_dir, output_file, extensions = ['.rb'])
    @input_dir = input_dir
    @output_file = output_file
    @extensions = extensions
  end

  def write
    entries = Dir.entries(@input_dir) - %w[. ..]

    ::Zip::File.open(@output_file, create: true) do |zipfile|
      write_entries entries, '', zipfile, @extensions
    end
  end

  private

  def write_entries(entries, path, zipfile, extensions)
    entries.each do |e|
      zipfile_path = path == '' ? e : File.join(path, e)
      disk_file_path = File.join(@input_dir, zipfile_path)

      if File.directory? disk_file_path
        recursively_deflate_directory(disk_file_path, zipfile, zipfile_path, extensions)
      else
        put_into_archive(disk_file_path, zipfile, zipfile_path, extensions)
      end
    end
  end

  def recursively_deflate_directory(disk_file_path, zipfile, zipfile_path, extensions)
    zipfile.mkdir zipfile_path
    subdir = Dir.entries(disk_file_path) - %w[. ..]
    write_entries subdir, zipfile_path, zipfile, extensions
  end

  def put_into_archive(disk_file_path, zipfile, zipfile_path, extensions)
    if extensions.any? { |ext| ext == File.extname(disk_file_path)}
      zipfile.add(zipfile_path, disk_file_path)
    end
  end
end