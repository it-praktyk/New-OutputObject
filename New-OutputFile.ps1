Function New-OutputFile {
<#

    .SYNOPSIS
    Function intended for preparing filename for output files like reports or logs
   
    .DESCRIPTION
    Function intended for preparing filename for output files like reports or logs based on prefix, middle name part, suffix, date, etc. with verification if provided path is writable
    
    Returned object contains properties
    - OutputFilePath - to use it please check an examples - as a [System.IO.FileInfo]
    - ExitCode
    - ExitCodeDescription
    
    Exit codes and descriptions
    0 = "Everything is fine :-)"
    1 = "Provided path <PATH> doesn't exist and can't be created
    2 = "Provided patch <PATH> doesn't exist and value for the parameter CreateOutputFileDirectory is set to False"
    3 = "Provided patch <PATH> is not writable"
    4 = "The file <PATH>\<FILE_NAME> already exist"
    
    .PARAMETER OutputFileDirectoryPath
    By default output files are stored in subfolder "outputs" in current path
    
    .PARAMETER CreateOutputFileDirectory
    Set tu TRUE if provided output file directory should be created if is missed
    
    .PARAMETER OutputFileNamePrefix
    Prefix used for creating output files name
    
    .PARAMETER OutputFileNameMidPart
    Part of the name which will be used in midle of output file name
    
    .PARAMETER OutputFileNameSuffixPart
    Part of the name which will be used at the end of output file name
    
    .PARAMETER IncludeDateTimePartInOutputFileName
    Set to TRUE if report file name should contains part based on date and time - format yyyyMMdd-HHmm is used
    
    .PARAMETER DateTimePartInOutputFileName
    Set to date and time which should be used in output file name, by default current date and time is used
    
    .PARAMETER OutputFileNameExtension
    Set to extension which need to be used for output file, by default ".txt" is used
    
    .PARAMETER ErrorIfOutputFileExist
    Generate error if output file already exist
    
    .PARAMETER BreakIfError
    Break function execution if parameters provided for output file creation are not correct or destination file path is not writables
    
    .EXAMPLE
    
    PS \> $PerServerReportFileMessages = New-OutputFile -OutputFileDirectoryPath 'C:\USERS\Wojtek\' -OutputFileNamePrefix 'Messages' `
                                                                    -OutputFileNameMidPart 'COMPUTERNAME' `
                                                                    -IncludeDateTimePartInOutputFileName:$true `
                                                                    -BreakIfError:$true
    
    PS \> $PerServerReportFileMessages | Format-List
    
    OutputFilePath                                           ExitCode ExitCodeDescription
    --------------                                           -------- -------------------
    C:\users\wojtek\Messages-COMPUTERNAME-20151021-0012-.txt        0 Everything is fine :-)
    
    .EXAMPLE
    
    PS \> $PerServerReportFileMessages = New-OutputFile -OutputFileDirectoryPath 'C:\USERS\Wojtek\' -OutputFileNamePrefix 'Messages' `
                                                                    -OutputFileNameMidPart 'COMPUTERNAME' -IncludeDateTimePartInOutputFileName:$true 
                                                                    -OutputFileNameExtension rxc -OutputFileNameSuffix suffix `
                                                                    -BreakIfError:$true
    
    
    PS \> $PerServerReportFileMessages.OutputFilePath | select name,extension,Directory | Format-List

    Name      : Messages-COMPUTERNAME-20151022-235607-suffix.rxc
    Extension : .rxc
    Directory : C:\USERS\Wojtek
    
    PS \> ($PerServerReportFileMessages.OutputFilePath).gettype()

    IsPublic IsSerial Name                                     BaseType
    -------- -------- ----                                     --------
    True     True     FileInfo                                 System.IO.FileSystemInfo
	
	.OUTPUTS
    System.Object[]
     
    .LINK
    https://github.com/it-praktyk/New-OutputFile
    
    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
          
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell
   
    VERSIONS HISTORY
    - 0.1.0 - 2015-09-01 - Initial release
    - 0.1.1 - 2015-09-01 - Minor update
    - 0.2.0 - 2015-09-08 - Corrected, function renamed to New-OutputFile from New-ReportFileNameFullPath
    - 0.3.0 - 2015-09-13 - implementation for DateTimePartInFileName parameter corrected, help updated, some parameters renamed
    - 0.4.0 - 2015-10-20 - additional OutputFileNameSuffix parameter added, help updated, TODO updated
    - 0.4.1 - 2015-10-21 - help corrected
    - 0.5.0 - 2015-10-22 - Returned OutputFilePath changed to type [System.IO.FileInfo], help updated
	- 0.6.0 - 2016-01-04 - The function renamed from New-OutputFileNameFullPath to New-OutputFile, help and TODO updated
	
    
    TODO
    - Change/extend behavior if file exist ?
    - Trim provided parameters
	- Replace not standard chars ? 
	- Add support to incrementint suffix -like "000124"
	- Resolve warning generated by PSScriptAnalyzer "Function 'New-OutputFile' has verb that could change system state. 
	Therefore, the function has to support 'ShouldProcess'."

        
    LICENSE
    Copyright (C) 2016 Wojciech Sciesinski
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
	[OutputType([System.Object[]])]
    param (
        [parameter(Mandatory = $false)]
        [String]$OutputFileDirectoryPath = ".\Outputs\",
        [parameter(Mandatory = $false)]
        [Bool]$CreateOutputFileDirectory = $true,
        [parameter(Mandatory = $false)]
        [String]$OutputFileNamePrefix = "Output-",
        [parameter(Mandatory = $false)]
        [String]$OutputFileNameMidPart = $null,
        [parameter(Mandatory = $false)]
        [String]$OutputFileNameSuffix = $null,
        [parameter(Mandatory = $false)]
        [Bool]$IncludeDateTimePartInOutputFileName = $true,
        [parameter(Mandatory = $false)]
        [Nullable[DateTime]]$DateTimePartInOutputFileName = $null,
        [parameter(Mandatory = $false)]
        [String]$OutputFileNameExtension = ".txt",
        [parameter(Mandatory = $false)]
        [Bool]$ErrorIfOutputFileExist = $true,
        [parameter(Mandatory = $false)]
        [Bool]$BreakIfError = $true
        
    )
    
    #Declare variable
    
    [Int]$ExitCode = 0
    
    [String]$ExitCodeDescription = "Everything is fine :-)"
    
    $Result = New-Object -TypeName PSObject
    
    #Convert relative path to absolute path
    [String]$OutputFileDirectoryPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputFileDirectoryPath)
    
    #Assign value to the variable $IncludeDateTimePartInOutputFileName if is not initialized
    If ($IncludeDateTimePartInOutputFileName -and $DateTimePartInOutputFileName -eq $null) {
        
        [String]$DateTimePartInFileNameString = $(Get-Date -format yyyyMMdd-HHmmss)
        
    }
    Else {
        
        [String]$DateTimePartInFileNameString = $(Get-Date -Date $DateTimePartInOutputFileName -format yyyyMMdd-HHmmss)
        
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
    
    Remove-Item -Path $TempFilePath -ErrorAction SilentlyContinue | Out-Null
        
    #Constructing the file name
    If (!($IncludeDateTimePartInOutputFileName) -and !([String]::IsNullOrEmpty($OutputFileNameMidPart)) ) {
        
        [String]$OutputFilePathTemp1 = "{0}\{1}-{2}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $OutputFileNameMidPart
        
    }
    Elseif (!($IncludeDateTimePartInOutputFileName) -and [String]::IsNullOrEmpty($OutputFileNameMidPart )) {
        
        [String]$OutputFilePathTemp1 = "{0}\{1}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix
        
    }
    ElseIf ($IncludeDateTimePartInOutputFileName -and !([String]::IsNullOrEmpty($OutputFileNameMidPart))) {
        
        [String]$OutputFilePathTemp1 = "{0}\{1}-{2}-{3}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $OutputFileNameMidPart, $DateTimePartInFileNameString
        
    }
    Else {
        
        [String]$OutputFilePathTemp1 = "{0}\{1}-{2}" -f $OutputFileDirectoryPath, $OutputFileNamePrefix, $DateTimePartInFileNameString
        
    }
    
    If ( [String]::IsNullOrEmpty($OutputFileNameSuffix)) {
        
        [String]$OutputFilePathTemp = "{0}.{1}" -f $OutputFilePathTemp1, $OutputFileNameExtension
        
    }
    Else {
        
        [String]$OutputFilePathTemp = "{0}-{1}.{2}" -f $OutputFilePathTemp1, $OutputFileNameSuffix, $OutputFileNameExtension
        
    }
    
    #Replacing doubled chars \\ , -- , .. - except if \\ is on begining - means that path is UNC share
    [System.IO.FileInfo]$OutputFilePath = "{0}{1}" -f $OutputFilePathTemp.substring(0, 2), (($OutputFilePathTemp.substring(2, $OutputFilePathTemp.length - 2).replace("\\", '\')).replace("--", "-")).replace("..", ".")
    
    If ($ErrorIfOutputFileExist -and (Test-Path -Path $OutputFilePath -PathType Leaf)) {
        
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