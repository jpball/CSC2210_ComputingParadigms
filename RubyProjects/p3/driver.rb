require_relative 'FileSystemCollector'

# p3 Driver
def __MAIN()
    fsc = FileSystemCollector.new("./testDir/")

    fsc.collect("txt")

    fsc.txts.zip("./textZip.zip")

end

__MAIN();