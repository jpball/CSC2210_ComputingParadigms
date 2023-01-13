class FileSystemHelper
  def get_paths(path_to_dir)
    #get all of the entries from the passed in directory
    #this method always returns the current working dir 
    #and parent directory in the array as the first two elements
    all_entries = Dir.entries(path_to_dir)

    #if there are only the current working directory, ".", and the parent dir,  ".." 
    if(all_entries.length == 2)
      #return an empty array
      all_entries = []
    else #non-empty directory
      #slice . and .. from the array
      all_entries = all_entries.slice(2, all_entries.length - 2)
    end

    return all_entries
  end
end