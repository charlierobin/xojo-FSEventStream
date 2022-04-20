#tag Module
Protected Module FSEventStream
	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub addPath Lib dylib (path as CFStringRef)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub clearPaths Lib dylib ()
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function getFlags(flagsUInt as UInt32) As Flag()
		  var flags() as Flag
		  
		  if flagsUInt = 0 then
		    
		    flags.Append( Flag.None )
		    
		  else
		    
		    var s as String = flagsUInt.ToBinary()
		    
		    var newS as String = ""
		    
		    for i as Integer = 0 to s.Length() - 1
		      
		      newS = s.Middle( i, 1 ) + news
		      
		    next
		    
		    s = newS
		    
		    if s.Middle( 0, 1 ) = "1" then flags.Append( Flag.MustScanSubDirs )
		    if s.Middle( 1, 1 ) = "1" then flags.Append( Flag.UserDropped )
		    if s.Middle( 2, 1 ) = "1" then flags.Append( Flag.KernelDropped )
		    if s.Middle( 3, 1 ) = "1" then flags.Append( Flag.EventIdsWrapped )
		    if s.Middle( 4, 1 ) = "1" then flags.Append( Flag.HistoryDone )
		    if s.Middle( 5, 1 ) = "1" then flags.Append( Flag.RootChanged )
		    if s.Middle( 6, 1 ) = "1" then flags.Append( Flag.Mount )
		    if s.Middle( 7, 1 ) = "1" then flags.Append( Flag.Unmount )
		    if s.Middle( 14, 1 ) = "1" then flags.Append( Flag.ItemChangeOwner )
		    if s.Middle( 8, 1 ) = "1" then flags.Append( Flag.ItemCreated )
		    if s.Middle( 13, 1 ) = "1" then flags.Append( Flag.ItemFinderInfoMod )
		    if s.Middle( 10, 1 ) = "1" then flags.Append( Flag.ItemInodeMetaMod )
		    if s.Middle( 17, 1 ) = "1" then flags.Append( Flag.ItemIsDir )
		    if s.Middle( 16, 1 ) = "1" then flags.Append( Flag.ItemIsFile )
		    if s.Middle( 20, 1 ) = "1" then flags.Append( Flag.ItemIsHardlink )
		    if s.Middle( 21, 1 ) = "1" then flags.Append( Flag.ItemIsLastHardlink )
		    if s.Middle( 18, 1 ) = "1" then flags.Append( Flag.ItemIsSymlink )
		    if s.Middle( 12, 1 ) = "1" then flags.Append( Flag.ItemModified )
		    if s.Middle( 9, 1 ) = "1" then flags.Append( Flag.ItemRemoved )
		    if s.Middle( 11, 1 ) = "1" then flags.Append( Flag.ItemRenamed )
		    if s.Middle( 15, 1 ) = "1" then flags.Append( Flag.ItemXattrMod )
		    if s.Middle( 19, 1 ) = "1" then flags.Append( Flag.OwnEvent )
		    if s.Middle( 22, 1 ) = "1" then flags.Append( Flag.ItemCloned )
		    
		  end if
		  
		  return flags
		  
		  
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub installCallback Lib dylib (handler as Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub run Lib dylib ()
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub stop Lib dylib ()
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function ToString(flags() as Flag) As String
		  var flagsAsString as String = ""
		  
		  for each flag as FSEventStream.Flag in flags
		    
		    flagsAsString = flagsAsString + FSEventStream.ToString( flag ) + ", "
		    
		  next
		  
		  flagsAsString = flagsAsString.TrimRight( ", " )
		  
		  return flagsAsString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ToString(f as Flag) As String
		  select case f
		    
		  case Flag.None
		    
		    return "None"
		    
		  case Flag.MustScanSubDirs
		    
		    return "MustScanSubDirs"
		    
		  case Flag.UserDropped
		    
		    return "UserDropped"
		    
		  case Flag.KernelDropped
		    
		    return "KernelDropped"
		    
		  case Flag.EventIdsWrapped
		    
		    return "EventIdsWrapped"
		    
		  case Flag.HistoryDone
		    
		    return "HistoryDone"
		    
		  case Flag.RootChanged
		    
		    return "RootChanged"
		    
		  case Flag.Mount
		    
		    return "Mount"
		    
		  case Flag.Unmount
		    
		    return "Unmount"
		    
		  case Flag.ItemChangeOwner
		    
		    return "ItemChangeOwner"
		    
		  case Flag.ItemCreated
		    
		    return "ItemCreated"
		    
		  case Flag.ItemFinderInfoMod
		    
		    return "ItemFinderInfoMod"
		    
		  case Flag.ItemInodeMetaMod
		    
		    return "ItemInodeMetaMod"
		    
		  case Flag.ItemIsDir
		    
		    return "ItemIsDir"
		    
		  case Flag.ItemIsFile
		    
		    return "ItemIsFile"
		    
		  case Flag.ItemIsHardlink
		    
		    return "ItemIsHardlink"
		    
		  case Flag.ItemIsLastHardlink
		    
		    return "ItemIsLastHardlink"
		    
		  case Flag.ItemIsSymlink
		    
		    return "ItemIsSymlink"
		    
		  case Flag.ItemModified
		    
		    return "ItemModified"
		    
		  case Flag.ItemRemoved
		    
		    return "ItemRemoved"
		    
		  case Flag.ItemRenamed
		    
		    return "ItemRenamed"
		    
		  case Flag.ItemXattrMod
		    
		    return "ItemXattrMod"
		    
		  case Flag.OwnEvent
		    
		    return "OwnEvent"
		    
		  case Flag.ItemCloned
		    
		    return "ItemCloned"
		    
		  case else
		    
		    return "Unknown"
		    
		  end select
		  
		  return "You should never see this!"
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = reference
		https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/FSEvents_ProgGuide/UsingtheFSEventsFramework/UsingtheFSEventsFramework.html
		
		https://stackoverflow.com/questions/30285529/watching-for-filesystem-events-on-macos-10-10
		
		IDs are uint64_t, flagsUInt unsigned long
		
		https://developer.apple.com/documentation/coreservices/1455361-FSEventStreamflags
		
		
		
	#tag EndNote


	#tag Constant, Name = dylib, Type = String, Dynamic = False, Default = \"@executable_path/../Frameworks/libFSEventStream.dylib", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Flag, Type = Integer, Flags = &h1
		None
		  MustScanSubDirs
		  UserDropped
		  KernelDropped
		  EventIdsWrapped
		  HistoryDone
		  RootChanged
		  Mount
		  Unmount
		  ItemChangeOwner
		  ItemCreated
		  ItemFinderInfoMod
		  ItemInodeMetaMod
		  ItemIsDir
		  ItemIsFile
		  ItemIsHardlink
		  ItemIsLastHardlink
		  ItemIsSymlink
		  ItemModified
		  ItemRemoved
		  ItemRenamed
		  ItemXattrMod
		  OwnEvent
		ItemCloned
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
