require_relative "FileSystemHelper"
require "test/unit" 
require "FileUtils"

class TestFileSystemHelper < Test::Unit::TestCase 
  def setup 
    #create some files and dirs

    #start with a topmost test dir
    Dir.mkdir("./test/")
    
    #an empty directory
    Dir.mkdir("./test/empty")

    #a dir with only files
    Dir.mkdir("./test/allFiles")
    File.new("./test/allFiles/test1.txt", "w")
    File.new("./test/allFiles/test2.txt", "w")
    File.new("./test/allFiles/test3.txt", "w")

    #a dir with only subdirs
    Dir.mkdir("./test/allDirs")
    Dir.mkdir("./test/allDirs/dir1")
    Dir.mkdir("./test/allDirs/dir2")
    Dir.mkdir("./test/allDirs/dir3")
    
    #a dir with files and dirs
    Dir.mkdir("./test/filesAndDirs")
    File.new("./test/filesAndDirs/test1.txt", "w")
    File.new("./test/filesAndDirs/test2.txt", "w")
    File.new("./test/filesAndDirs/test3.txt", "w")
    Dir.mkdir("./test/filesAndDirs/dir1")
    Dir.mkdir("./test/filesAndDirs/dir2")
    Dir.mkdir("./test/filesAndDirs/dir3")

    #create the file system helper that each test will use
    @fsh = FileSystemHelper.new
  end 

  def teardown 
    #remove all the files and dirs in the ./test/ dir
    #FileUtils.rm_r("./test/")
    FileUtils.remove_dir("./test/", true)
  end 

  #empty dirs should return an empty array
  def test_empty_dir
    assert_equal([], @fsh.get_paths("./test/empty"))
  end

  #should include all of the file names (in any order)
  def test_only_files
    assert(@fsh.get_paths("./test/allFiles").include?("test1.txt"))
    assert(@fsh.get_paths("./test/allFiles").include?("test2.txt"))
    assert(@fsh.get_paths("./test/allFiles").include?("test3.txt"))
  end

  #should include all of the dir names (in any order)
  def test_only_dirs
    assert(@fsh.get_paths("./test/allDirs").include?("dir1"))
    assert(@fsh.get_paths("./test/allDirs").include?("dir2"))
    assert(@fsh.get_paths("./test/allDirs").include?("dir3"))
  end

  #should include files and dirs
  def test_files_and_dirs
    assert(@fsh.get_paths("./test/filesAndDirs").include?("test1.txt"))
    assert(@fsh.get_paths("./test/filesAndDirs").include?("test2.txt"))
    assert(@fsh.get_paths("./test/filesAndDirs").include?("test3.txt"))
    assert(@fsh.get_paths("./test/filesAndDirs").include?("dir1"))
    assert(@fsh.get_paths("./test/filesAndDirs").include?("dir2"))
    assert(@fsh.get_paths("./test/filesAndDirs").include?("dir3"))
  end
end