require 'zip'
# Tests found in testFSC.rb
class FileSystemCollector
  # Constructor
  def initialize(path_to_dir)
    @dir_path = path_to_dir
  end

  def dirs(&block)
    recursive_dir_search(@dir_path) { |p, fn|  block.call(p, fn) }
  end

  def files(&block)
    recursive_file_seach(@dir_path) { |p, fn, e|  block.call(p, fn, e) }
  end

  # Allows one to specify a group of file types together.
  # For example, I might want to collect all of the media
  # files starting in the topmost directory.
  # I can define the extensions that I want to call 'media' files:
  def collect(name, *extensions)
    if extensions.count.zero?
      Single_Collect(name)
    else
      Multi_Collect(name, *extensions)
    end
  end

  private
  def recursive_dir_search(path_to_dir, &block)
    Dir.children(path_to_dir).each do |file|
      # For each of the items in the directory
      if(File.directory?(File.join(path_to_dir, file)))
        # File is a directory
        block.call(path_to_dir, file)
        recursive_dir_search(File.join(path_to_dir, file)) { |p, fn| block.call(p, fn) }
      end
    end
  end


  def recursive_file_seach(path_to_dir, &block)
    # go through the contents of a directory
    Dir.children(path_to_dir).each do |filename|
      fullPath = File.join(path_to_dir, filename)
      if(File.file?(fullPath))
        # Path is a file
        block.call(File.dirname(fullPath), File.basename(fullPath, ".*"), File.extname(fullPath).delete("."))
      else
        recursive_file_seach(fullPath) { |p, fn, e| block.call(p, fn, e) }
      end
    end
  end



  # Will take a single parameter which is
  # a file extension and a new method should
  # be added to the object with the pluralized
  # name that will return all files with that extension
  def Single_Collect(extension)
    ext_str = "#{extension}s"
    instance_eval(
      "def #{ext_str}\n
        if(@#{ext_str} == nil)
          @#{ext_str} = FileSystemCollector.new(@dir_path)
        end

        @#{ext_str}.instance_eval do
          def all\n
            files do |p, fn, e|
              if e == \"#{extension}\"
                yield File.join(p, \"\#{fn}.\#{e}\")
              end
            end
          end

          def zip(path)
            Zip::File.open(path, Zip::File::CREATE) do |zipfile|
              all do |filename|
                # Two arguments:
                # - The name of the file as it will appear in the archive
                # - The original file, including the path to find it
                zipfile.add(File.basename(filename), filename)
              end
            end
          end

          def remove
            all do |file_path|
              File.delete(file_path)
            end
          end
        end
        return @#{ext_str}
      end\n"
    )
  end

def Multi_Collect(name, *extensions)
  instance_eval(
    "def #{name}\n
        if(@#{name} == nil)
          @#{name} = FileSystemCollector.new(@dir_path)
        end
          @#{name}.instance_eval do
          def all
            allExt = #{extensions}
            files do |p, fn, e|
              if allExt.include?(e)
                yield File.join(p, \"\#{fn}.\#{e}\")
              end
            end
          end

          def zip(path)
            Zip::File.open(path, Zip::File::CREATE) do |zipfile|
              all do |filename|
                # Two arguments:
                # - The name of the file as it will appear in the archive
                # - The original file, including the path to find it
                zipfile.add(File.basename(filename), filename)
              end
            end
          end

          def remove
            all do |file_path|
              File.delete(file_path)
            end
          end
        end
        return @#{name}
    end\n")
  end
end
