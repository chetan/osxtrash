
require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

class OSXTrash

    def initialize
        @finder = create_finder
    end

    def list
        items = []
        trash = @finder.trash
        trash.items.each do |item|
            file_url = NSURL.URLWithString(item.URL)
            Pathname item_path = Pathname.new(file_url.path) # really needed?
            items << item_path.to_s
        end
        return items
    end

    def delete(files)
        files = [ files ] if files.kind_of? String
        files.each do |file|
            path = Pathname.new(file)
            url = NSURL.fileURLWithPath(path.realpath.to_s)
            item = @finder.items.objectAtLocation(url)
            item.delete
        end
        return
    end


    private

    def create_finder
        stderr = $stderr.clone           # save current STDERR IO instance
        $stderr.reopen('/dev/null', 'w') # send STDERR to /dev/null
        finder = SBApplication.applicationWithBundleIdentifier("com.apple.Finder")
        $stderr.reopen(stderr)           # revert to default behavior
        return finder
    end

end

