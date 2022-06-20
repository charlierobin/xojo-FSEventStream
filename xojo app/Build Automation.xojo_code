#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyFiles1
					AppliesTo = 0
					Architecture = 0
					Destination = 2
					Subdirectory = 
					FolderItem = Li4vLi4vZHlsaWIvbGliRlNFdmVudFN0cmVhbS5keWxpYg==
				End
				Begin IDEScriptBuildStep ScriptDropBoxIgnoreRelease , AppliesTo = 2, Architecture = 0
					// we want the “parent” Builds folder, not the platform specific one
					
					// can use native (unescaped) paths as wrapped in quotes in DoShellCommand below
					
					var bits() as String = CurrentBuildLocationNative.Split( "/" )
					
					var path as String
					
					for i as Integer = 0 to bits.LastRowIndex - 1
					
					path = path + bits( i )
					
					if i < bits.LastRowIndex - 1 then path = path + "/"
					
					next
					
					var result as String = DoShellCommand( "xattr -w com.dropbox.ignored 1 """ + path + """" )
					
					if result <> "" then print( result )
					
					
				End
				Begin IDEScriptBuildStep ScriptDropBoxIgnoreDebug , AppliesTo = 1, Architecture = 0
					// can use native (unescaped) paths as wrapped in quotes in DoShellCommand below
					
					var path as String = CurrentBuildLocationNative + "/" + CurrentBuildAppName + ".app"
					
					var result as String = DoShellCommand( "xattr -w com.dropbox.ignored 1 """ + path + """" )
					
					if result <> "" then print( result )
					
					
				End
				Begin IDEScriptBuildStep ScriptIgnoreDotGit , AppliesTo = 0, Architecture = 0
					var result as String = DoShellCommand( "xattr -w com.dropbox.ignored 1 ""$PROJECT_PATH/../.git""" )
					
					if result <> "" then print( result )
					
					
				End
				Begin IDEScriptBuildStep ScriptUpdateVersion , AppliesTo = 0, Architecture = 0
					var v as String = ""
					
					v = PropertyValue( "App.MajorVersion" ) + "." + PropertyValue( "App.MinorVersion" ) + "." + PropertyValue( "App.BugVersion" ) + "."
					
					v = v + PropertyValue( "App.StageCode" ) + "."
					
					v = v + PropertyValue( "App.NonReleaseVersion" )
					
					PropertyValue( "App.Version" ) = v
					
					
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
