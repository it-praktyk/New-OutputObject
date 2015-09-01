Function New-ReportFileNameFullPath {

<#

	.SYNOPSIS
	Function intended for 
   
	.DESCRIPTION
	
	.PARAMETER CreateReportFileDirectory
	
	.PARAMETER ReportFileDirectoryPath
	
	.PARAMETER ReportFileNamePrefix
	
	.PARAMETER ReportFileNameMidPart
	
	.PARAMETER IncludeDateTimePartInFileName
	
	.PARAMETER DateTimePartInFileName
	
	.PARAMETER ReportFileNameExtension
	
	.PARAMETER CheckIfReportFileExist
	
	.PARAMETER BreakIfError

	.EXAMPLE
	
	[PS] > New-ReportFileNameFullPath 
	 
	.LINK
	https://github.com/it-praktyk/New-ReportFileNameFullPath
	
	.LINK
	https://www.linkedin.com/in/sciesinskiwojciech
		  
	.NOTES
	AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
	KEYWORDS: PowerShell
   
	VERSIONS HISTORY
	0.1.0 - 2015-09-01 - Initial release
	
	TODO
	Update help

		
	LICENSE
	Copyright (C) 2015 Wojciech Sciesinski
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.
	You should have received a copy of the GNU General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>
	
#>
	

param (

	[parameter(Mandatory = $false)]
	[Switch]$CreateReportFileDirectory = $true,
        
    [parameter(Mandatory = $false)]
	[String]$ReportFileDirectoryPath = ".\reports\",
        
	[parameter(Mandatory = $false)]
	[String]$ReportFileNamePrefix = "Report-",
	
	[parameter(Mandatory = $false)]
	[String]$ReportFileNameMidPart,
	
	[parameter(Mandatory = $false)]
	[Switch]$IncludeDateTimePartInFileName = $true,
	
	[parameter(Mandatory = $false)]
	[String]$DateTimePartInFileName, 
	
	[parameter(Mandatory = $false)]
	[String]$ReportFileNameExtension = ".csv",
	
	[parameter(Mandatory = $false)]
	[Switch]$CheckIfReportFileExist=$true,
		
	[parameter(Mandatory = $false)]
	[Switch]$BreakIfError=$true

)

	#Declare variable
	
	[Int]$ExitCode = 0
	
	[String]$ErrorDescription = $null
	
	$Result = New-Object PSObject

	#Convert relative path to absolute path
	[String]$ReportFileDirectoryPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ReportFileDirectoryPath)

	#Assign value to the variable $IncludeDateTimePartInFileName if is not initialized
	If ( $IncludeDateTimePartInFileName -and $DateTimePartInFileName -eq "" ) {
	
		[String]$DateTimePartInFileName = $(Get-Date -format yyyyMMdd-HHmm)
		
	}
            
    #Check if report directory exist and try create if not
		
	If ( $CreateReportFileDirectory -and !$((Get-Item -Path $ReportFileDirectoryPath -ErrorAction SilentlyContinue) -is [system.io.directoryinfo])) {
	
		Try {
                
			$ErrorActionPreference = 'Stop'
				
			New-Item -Path $ReportFileDirectoryPath -type Directory | Out-Null
		
		}
		Catch {
		
			[String]$MessageText = "Provided path {0} doesn't exist and can't be created" -f $ReportFileDirectoryPath
			
			If ( $BreakIfError ) {
		
				Throw $MessageText
				
			}
			Else {
			
				Write-Error -Message $MessageText
				
				[Int]$ExitCode = 1
				
				[String]$ErrorDescription = $MessageText

			}
		
		}
                
    }
	ElseIf (!$((Get-Item -Path $ReportFileDirectoryPath -ErrorAction SilentlyContinue) -is [system.io.directoryinfo])) {
	
		[String]$MessageText = "Provided patch {0} doesn't exist and value for the parameter CreateReportFileDirectory is set to False" -f $ReportFileDirectoryPath
		
		If ( $BreakIfError ) {
		
			Throw $MessageText
				
		}
		Else {
			
			Write-Error -Message $MessageText
							
			[Int]$ExitCode = 2
				
			[String]$ErrorDescription = $MessageText
			
		}
	
	}
	
	#Try if report directory is writable - temporary file is stored
	Try {
	
		$ErrorActionPreference = 'Stop'
		
		[String]$TempFileName = [System.IO.Path]::GetTempFileName() -replace '.*\\', ''
		
		[String]$TempFilePath = "{0}{1}" -f $ReportFileDirectoryPath , $TempFileName
		
		New-Item -Path $TempFilePath  -type File | Out-Null
		
	}
	Catch {
		
		[String]$MessageText = "Provided patch {0} is not writable" -f $ReportFileDirectoryPath
			
		If ( $BreakIfError ) {
		
			Throw $MessageText
				
		}
		Else {
			
			Write-Error -Message $MessageText
							
			[Int]$ExitCode = 3
				
			[String]$ErrorDescription = $MessageText
			
		}
					
	}
		
	Remove-Item $TempFilePath -ErrorAction SilentlyContinue | Out-Null		
	
	
	#Constructing the file name
	If ( !($IncludeDateTimePartInFileName) -and ( $ReportFileNameMidPart -ne $null ) ) {
	
		[String]$ReportFilePathTemp = "{0}\{1}-{2}.{3}" -f $ReportFileDirectoryPath, $ReportFileNamePrefix, $ReportFileNameMidPart, $ReportFileNameExtension
	
	}
	Elseif ( !($IncludeDateTimePartInFileName) -and ( $ReportFileNameMidPart -eq $null ) ) {
	
		[String]$ReportFilePathTemp = "{0}\{1}.{2}" -f $ReportFileDirectoryPath, $ReportFileNamePrefix, $ReportFileNameExtension
	
	}
	ElseIf ( $IncludeDateTimePartInFileName -and ( $ReportFileNameMidPart -ne $null )) {
	
		[String]$ReportFilePathTemp = "{0}\{1}-{2}-{3}.{4}" -f $ReportFileDirectoryPath, $ReportFileNamePrefix, $ReportFileNameMidPart, $DateTimePartInFileName, $ReportFileNameExtension
	
	}
	Else {
		
		[String]$ReportFilePathTemp = "{0}\{1}-{2}.{3}" -f $ReportFileDirectoryPath, $ReportFileNamePrefix, $DateTimePartInFileName, $ReportFileNameExtension
	
	}

	#Replacing doubled chars \\ , -- , ..
	[String]$ReportFilePath = "{0}{1}" -f $ReportFilePathTemp.substring(0,2) , (($ReportFilePathTemp.substring(2,$ReportFilePathTemp.length-2).replace("\\",'\')).replace("--","-")).replace("..",".")
	
	If ( $CheckIfReportFileExist - and Test-Path -Path $ReportFilePath -PathType Leaf ) {
	
		[String]$MessageText = "The file {0} already exist" -f $ReportFilePath
			
		If ( $BreakIfError ) {
		
			Throw $MessageText
				
		}
		Else {
			
			Write-Error -Message $MessageText
							
			[Int]$ExitCode = 4
				
			[String]$ErrorDescription = $MessageText
			
		}	
	}
	
	$Result | Add-Member -MemberType NoteProperty -Name ExitCode -Value
	
	$Result | Add-Member -MemberType NoteProperty -Name ReportFilePath -Value $ReportFilePath
	
	Return $Result

}