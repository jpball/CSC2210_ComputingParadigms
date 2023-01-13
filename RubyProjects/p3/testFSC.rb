require 'test/unit'
require_relative 'FileSystemCollector'


class TestFileSystemCollector < Test::Unit::TestCase
    def setup
        puts("--- Setting up")
        #create some files and dirs
        #start with a topmost test dir
        @root_path = "./testEnv/"
        if(Dir.exist?(@root_path))
            puts("--- TestEnv already exists:: Deleting...")
            FileUtils.remove_dir(@root_path, true)
        end
        Dir.mkdir(@root_path)
        puts("--- Test Dir created")
        Dir.chdir(@root_path) # Enter @root_path
        File.new("./test1.txt", "w")
        File.new("./test2.cpp", "w")
        File.new("./test3.hpp", "w")

        Dir.mkdir("./dir1")
        Dir.chdir("./dir1") # Enter Dir1

        File.new("./test4.mp4", "w")
        File.new("./test5.txt", "w")

        Dir.chdir("..") # Exit Dir1

        Dir.mkdir("./dir2")
        Dir.chdir("./dir2") # Enter Dir2

        File.new("./test6.gif", "w")

        Dir.mkdir("./subdir1")
        Dir.chdir("./subdir1") # Enter subdir1

        File.new("./boop.txt", "w")

        Dir.chdir("..") # Exit subdir1
        Dir.chdir("..") # Exit Dir2

        Dir.chdir("..") # Exit @root_path
        @fsc = FileSystemCollector.new(@root_path);
    end

    def teardown
        FileUtils.remove_dir(@root_path, true)
        puts('Test Dir deleted ---')
        puts('Tearing down ---')
    end

    def test_dirs
        allDirs = []
        @fsc.dirs do |path, file_name|
            allDirs << File.join(path, file_name)
        end
        assert_equal(allDirs.count, 3)
        assert(allDirs.include?(File.join(@root_path, "dir1")))
        assert(allDirs.include?(File.join(@root_path, "dir2")))
        assert(allDirs.include?(File.join(@root_path, "dir2", "subdir1")))
    end

    def test_files
        allFiles = []
        @fsc.files do |p, f, e|
            allFiles << File.join(p, "#{f}.#{e}")
        end

        assert_equal(allFiles.count, 7)
        assert(allFiles.include?(File.join(@root_path, "test1.txt")))
        assert(allFiles.include?(File.join(@root_path, "test2.cpp")))
        assert(allFiles.include?(File.join(@root_path, "test3.hpp")))
        assert(allFiles.include?(File.join(@root_path, "dir1", "test4.mp4")))
        assert(allFiles.include?(File.join(@root_path, "dir1", "test5.txt")))
        assert(allFiles.include?(File.join(@root_path, "dir2", "subdir1", "boop.txt")))
        assert(allFiles.include?(File.join(@root_path, "dir2", "test6.gif")))
    end

    def test_all_many_code
        @fsc.collect("code", "cpp", "hpp")

        allCodeFiles = []
        @fsc.code.all do |path|
            allCodeFiles << path
        end

        assert_equal(allCodeFiles.count, 2) # We only have 2 files
        assert(allCodeFiles.include?(File.join(@root_path, "test2.cpp")))
        assert(allCodeFiles.include?(File.join(@root_path, "test3.hpp")))
    end

    def test_zip_many_code
        @fsc.collect("code", "cpp", "hpp")
        @fsc.code.zip(File.join(@root_path, "allCode.zip"))
        assert(File.exist?(File.join(@root_path, "allCode.zip")))
    end

    def test_remove_many_code
        @fsc.collect("code", "cpp", "hpp")

        @fsc.code.remove

        all_code_files = []
        @fsc.code.all do |path|
            all_code_files << path
        end

        assert_equal(all_code_files.count, 0)
        assert(!all_code_files.include?(File.join(@root_path, "test2.cpp")))
        assert(!all_code_files.include?(File.join(@root_path, "test3.hpp")))
    end

    def test_all_many_media
        @fsc.collect("media", "mp4", "gif")

        allMediaFiles = []
        @fsc.media.all do |path|
            allMediaFiles << path
        end

        assert_equal(allMediaFiles.count, 2)
        assert(allMediaFiles.include?(File.join(@root_path, "dir1", "test4.mp4")))
        assert(allMediaFiles.include?(File.join(@root_path, "dir2", "test6.gif")))
    end

    def test_zip_many_media
        @fsc.collect("media", "mp4", "gif")

        # Zip up the file
        @fsc.media.zip(File.join(@root_path, "allMedia.zip"))
        assert(File.exist?(File.join(@root_path, "allMedia.zip")))
    end

    def test_remove_many_media
        @fsc.collect("media", "mp4", "gif")

        @fsc.media.remove

        allMediaFiles = []
        @fsc.media.all do |path|
            allMediaFiles << path
        end

        assert_equal(allMediaFiles.count, 0)
        assert(!allMediaFiles.include?(File.join(@root_path, "dir1", "test4.mp4")))
        assert(!allMediaFiles.include?(File.join(@root_path, "dir2", "test6.gif")))
    end

    def test_all_single_txt
        @fsc.collect("txt")

        allTxtFiles = []
        @fsc.txts.all do |path|
            allTxtFiles << path
        end

        assert_equal(allTxtFiles.count, 3) # We only have 2 files
        assert(allTxtFiles.include?(File.join(@root_path, "test1.txt")))
        assert(allTxtFiles.include?(File.join(@root_path, "dir1", "test5.txt")))
        assert(allTxtFiles.include?(File.join(@root_path, "dir2", "subdir1", "boop.txt")))
    end

    def test_zip_single_txt
        @fsc.collect("txt")

        # Zip up the file
        @fsc.txts.zip(File.join(@root_path, "allTxt.zip"))
        assert(File.exist?(File.join(@root_path, "allTxt.zip")))
    end

    def test_remove_single_txt
        @fsc.collect("txt")

        # Zip up the file
        @fsc.txts.remove

        remainingTxt = []
        @fsc.txts.all do |path|
            remainingTxt << path
        end

        assert_equal(remainingTxt.count, 0)
        assert(!remainingTxt.include?(File.join(@root_path, "test1.txt")))
        assert(!remainingTxt.include?(File.join(@root_path, "dir1", "test5.txt")))
        assert(!remainingTxt.include?(File.join(@root_path, "dir2", "subdir1", "boop.txt")))
    end

end