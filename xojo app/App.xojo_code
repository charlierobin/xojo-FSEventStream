#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  try
		    
		    FSEventStream.stop()
		    
		  catch e as FunctionNotFoundException
		    
		    System.DebugLog( e.Message )
		    
		  end try
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  me.updateFSEventStreams()
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Sub callback_Handler(id as UInt64, path as CString, flagsUInt as UInt32)
		  var f as FolderItem = new FolderItem( path, FolderItem.PathModes.Native )
		  
		  if f.Name.Left( 1 ) = "." then return
		  
		  var flags() as FSEventStream.Flag = FSEventStream.getFlags( flagsUInt )
		  
		  WindowMain.TextAreaLog.AddText( "ID: " + str( id ) + " Path: " + path + " (Flags: " + FSEventStream.ToString( flags ) + ")" + EndOfLine )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateFSEventStreams()
		  try
		    
		    FSEventStream.stop()
		    
		    FSEventStream.clearPaths()
		    
		    if WindowMain.ListboxPaths.RowCount > 0 then
		      
		      FSEventStream.installCallback( AddressOf callback_Handler )
		      
		      for i as Integer = 0 to WindowMain.ListboxPaths.LastRowIndex
		        
		        FSEventStream.addPath( WindowMain.ListboxPaths.CellValueAt( i, 0 ) )
		        
		      next
		      
		      FSEventStream.run()
		      
		    end if
		    
		  catch e as FunctionNotFoundException
		    
		    System.DebugLog( e.Message )
		    
		  end try
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
