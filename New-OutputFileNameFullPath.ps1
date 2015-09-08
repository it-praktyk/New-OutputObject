Function New-OutputFileNameFullPath {
    
<#

	.SYNOPSIS
	Function intended for preparing filename for output files like reports or logs
   
	.DESCRIPTION
	Function intended for preparing filename for output files like reports or logs based on prefix, middle name part, date, etc. with verification
	
	.PARAMETER CreateOutputFileDirectory
	
	.PARAMETER OutputFileDirectoryPath
	
	.PARAMETER OutputFileNamePrefix
	
	.PARAMETER OutputFileNameMidPart
	
	.PARAMETER IncludeDateTimePartInFileName
	
	.PARAMETER DateTimePartInFileName
	
	.PARAMETER OutputFileNameExtension
	
	.PARAMETER CheckIfOutputFileExist
	
	.PARAMETER BreakIfError

	.EXAMPLE
	
	[PS] > New-OutputFileNameFullPath 
	 
	.LINK
	https://github.com/it-praktyk/New-OutputFileNameFullPath
	
	.LINK
	https://www.linkedin.com/in/sciesinskiwojciech
		  
	.NOTES
	AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
	KEYWORDS: PowerShell
   
	VERSIONS HISTORY
	0.1.0 - 2015-09-01 - Initial release
    0.1.1 - 2015-09-01 - Minor update
    0.2.0 - 2015-09-08 - Corrected, function renamed to New-OutputFileNameFullPath from New-ReportFileNameFullPath 
    
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
    
    [cmdletbinding()]
    
    param (
        
        [parameter(Mandatory = $false)]
        [Switch]$CreateOutputFileDirectory = $true,
        [parameter(Mandatory = $false)]
        [String]$OutputFileDirectoryPath = ".\Outputs\",
        [parameter(Mandatory = $false)]
        [String]$OutputFileNamePrefix = "Output-",
        [parameter(Mandatory = $false)]
        [String]$OutputFileNameMidPart,
        [parameter(Mandatory = $false)]
        [Switch]$IncludeDateTimePartInFileName = $true,
        [parameter(Mandatory = $false)]
        [String]$DateTimePartInFileName,
        [parameter(Mandatory = $false)]
        [String]$OutputFileNameExtension = ".csv",
        [parameter(Mandatory = $false)]
        [Switch]$CheckIfOutputFileExist = $true,
        [parameter(Mandatory = $false)]
        [Switch]$BreakIfError = $true
        
    )
    
    #Declare variable
    
    [Int]$ExitCode = 0
    
    [String]$ExitCodeDescription = $null
    
    $Result = New-Object PSObject
    
    #Convert relative path to absolute path
    [String]$OutputFileDirectoryPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputFileDirectoryPath)
    
    #Assign value to the variable $IncludeDateTimePartInFileName if is not initialized
    If ($IncludeDateTimePartInFileName -and $DateTimePartInFileName -eq "") {
        
        [String]$DateTimePartInFileName = $(Get-Date -format yyyyMMdd-HHmm)
        
    }
    
    #Check if Output directory exist and try create if not
    If ($CreateOutputFileDirectory -and !$((Get-Item -Path $OutputFileDirectoryPath -ErrorAction SilentlyContinue) -is [system.io.directoryinfo])) {
        
        Try {
            
            $ErrorActionPreference = 'Stop'
            
            New-Item -Path $OutputFileDirectoryPath -type Directory | Out-Null
            
        }
        Catch {
            
            [String]$MessageText = "Provided path {0} doesn't exist and can't be created" -f $OutputFileDirectoryPath
            
            If ($BreakIfError) {
                
                Throw $MessageText
                
            }
            Else {
                
                Write-Error -Message $MessageText
                
                [Int]$ExitCode = 1
                
                [String]$ExitCodeDescription = $MessageText
                
            }
            
        }
        
    }
    ElseIf (!$((Get-Item -Path $OutputFileDirectoryPath -ErrorAction SilentlyContinue) -is [system.io.directoryinfo])) {
        
        [String]$MessageText = "Provided patch {0} doesn't exist and value for the parameter CreateOutputFileDirectory is set to False" -f $OutputFileDirectoryPath
        
        If ($BreakIfError) {
            
            Throw $MessageText
            
        }
        Else {
            
            Write-Error -Message $MessageText
            
            [Int]$ExitCode = 2
            
            [String]$ExitCodeDescription = $MessageText
            
        }
        
    }
    
    #Try if Output directory is writable - temporary file is stored
    Try {
        
        $ErrorActionPreference = 'Stop'
        
        [String]$TempFileName = [System.IO.Path]::GetTempFileName() -replace '.*\\', ''
        
        [String]$TempFilePath = "{0}{1}" -f $OutputFileDirectoryPath, $TempFileName
        
        New-Item -Path $TempFilePath -type File | Out-Null
        
    }
    Catch {
        
        [String]$MessageText = "Provided patch {0} is not writable" -f $OutputFileDirectoryPath
        
        If ($BreakIfError) {
            
            Throw $MessageText
            
        }
        Else {
            
            Write-Error -Message $MessageText
            
            [Int]$ExitCode = 3
            
            [String]$ExitCodeDescription = $MessageText
            
        }
        
    }
    
    Remove-Item $TempFilePath -ErrorAction SilentlyContinue | Out-Null
    
    
    #Constructing the file name
    If (!($IncludeDateTimePartInFileName) -and ($OutputFileNameMidPart -ne $null)) {
        
        [String]$OutputFilePathTemp = "{0}\{1}-{2}.{3}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $OutputFileNameMidPart, $OutputFileNameExtension
        
    }
    Elseif (!($IncludeDateTimePartInFileName) -and ($OutputFileNameMidPart -eq $null)) {
        
        [String]$OutputFilePathTemp = "{0}\{1}.{2}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $OutputFileNameExtension
        
    }
    ElseIf ($IncludeDateTimePartInFileName -and ($OutputFileNameMidPart -ne $null)) {
        
        [String]$OutputFilePathTemp = "{0}\{1}-{2}-{3}.{4}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $OutputFileNameMidPart, $DateTimePartInFileName, $OutputFileNameExtension
        
    }
    Else {
        
        [String]$OutputFilePathTemp = "{0}\{1}-{2}.{3}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $DateTimePartInFileName, $OutputFileNameExtension
        
    }
    
    #Replacing doubled chars \\ , -- , ..
    [String]$OutputFilePath = "{0}{1}" -f $OutputFilePathTemp.substring(0, 2), (($OutputFilePathTemp.substring(2, $OutputFilePathTemp.length - 2).replace("\\", '\')).replace("--", "-")).replace("..", ".")
    
    If ($CheckIfOutputFileExist -and (Test-Path -Path $OutputFilePath -PathType Leaf)) {
        
        [String]$MessageText = "The file {0} already exist" -f $OutputFilePath
        
        If ($BreakIfError) {
            
            Throw $MessageText
            
        }
        Else {
            
            Write-Error -Message $MessageText
            
            [Int]$ExitCode = 4
            
            [String]$ExitCodeDescription = $MessageText
            
        }
    }
    
    $Result | Add-Member -MemberType NoteProperty -Name OutputFilePath -Value $OutputFilePath
    
    $Result | Add-Member -MemberType NoteProperty -Name ExitCode -Value $ExitCode
    
    $Result | Add-Member -MemberType NoteProperty -Name ExitCodeDescription -Value $ExitCodeDescription
    
    Return $Result
    
}