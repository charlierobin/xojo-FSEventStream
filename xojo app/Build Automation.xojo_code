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
					FolderItem = Li4vLi4vRlNFdmVudFN0cmVhbS9EZXJpdmVkRGF0YS9GU0V2ZW50U3RyZWFtL0J1aWxkL1Byb2R1Y3RzL0RlYnVnL2xpYkZTRXZlbnRTdHJlYW0uZHlsaWI=
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
