# FSEventStream for Xojo apps
 
A small dylib the hooks into OSX FSEventStream, allowing monitoring of directories.

Xcode project for the dylib is provided, there’s also a zipped prebuilt binary.

The API is very simple, I just wanted to test it out and see if it could be made to work.

`FSEventStream.installCallback( AddressOf callback_Handler )` installs a Xojo method as the handler for any events. (This has to be a shared method.) 

This handler needs to be signature `id as UInt64, path as CString, flagsUInt as UInt32`.

In the FSEventStream module there’s very simple (some might say crude) decoding of the bit flags for the returned UInt32 value `flagsUInt`, which in theory gives you more specific information about the actual event the occurred for that CString `path`.

With a callback installed, you can call `FSEventStream.addPath` with a string for each path you want monitored.

Once done, you can call `FSEventStream.run`.

Call `FSEventStream.stop` to stop callbacks.

`FSEventStream.clearPaths` clears all the paths you have added.

I was interested to find out if this could be a way of solving the problem of detecting when large files have finished copying/moving into a directory in the Finder, as the Xojo FolderItem class doesn’t seem to have any way of detecting that.

I’ve seen a few suggestions for handling this scenario, and tried a few solutions myself, but nothing seems to work. As soon as a file starts to be moved/copied to a directory, it’s available as a FolderItem, and there’s no way of detecting (if it’s a large file) if the file operation has actually completed (short of continuously monitoring size, as FolderItem.exists immediately returns true, the item can be opened for writing IO operations, and so on).

But with FSEventStream, you get two events when copying a large file with the Finder:

`ID: 12345 Path: /path/to/large_file_here (Flags: ItemCreated, ItemFinderInfoMod, ItemInodeMetaMod, ItemIsFile, ItemXattrMod)`

when the copy starts, then ...

`ID: 12345 Path: /path/to/large_file_here (Flags: ItemChangeOwner, ItemFinderInfoMod, ItemIsFile, ItemModified, ItemXattrMod)`

... when the copy completes.

Which to my mind gives a slightly better way of keeping an eye on potential incoming files in drop folders etc, as monitoring file size with a Timer (or something similar) can be a problem if the incoming data stalls for a bit (say, with a temporary network connection problem).

Charlie
