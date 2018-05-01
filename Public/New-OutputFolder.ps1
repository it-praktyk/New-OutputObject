Function New-OutputFolder {
<#

    .SYNOPSIS
    Function intended for preparing a PowerShell object for output/create folders for e.g. reports or logs.

    .DESCRIPTION
    Function intended for preparing a PowerShell custom object what contains e.g. folder name for output/create folders. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.

    Returned object contains properties
    - ParentPath - to use it please check an examples - as a [System.IO.DirectoyInfo]
    - ExitCode
    - ExitCodeDescription

    Exit codes and descriptions
    - 0 = "Everything is fine :-)"
    - 1 = "Provided parent path <PATH> doesn't exist"
    - 2 = "The result name contains unacceptable chars"
    - 3 = "Provided patch <PATH> is not writable"
    - 4 = "The folder <PATH>\\<FOLDER_NAME> already exist  - can be overwritten"
    - 5 = "The folder <PATH>\\<FOLDER_NAME> already exist  - can't be overwritten"

    .PARAMETER ParentPath
    The folder path what will be used as the parent path for the new created object.
    When non existing path will be provided the error code will be returned.

    By default output files are stored in the current path.

    .PARAMETER OutputFolderNamePrefix
    Prefix used for creating output folders name

    .PARAMETER OutputFolderNameMidPart
    Part of the name which will be used in midle of output folder name

    .PARAMETER OutputFolderNameSuffix
    Part of the name which will be used at the end of output folder name

    .PARAMETER IncludeDateTimePartInOutputFolderName
    Set to TRUE if report folder name should contains part based on date and time - format yyyyMMdd is used

    .PARAMETER DateTimePartInOutputFolderName
    Set to date and time which should be used in output folder name, by default current date and time is used

    .PARAMETER DateTimePartFormat
    Format string used to format date and time in output folder name.

    .PARAMETER NamePartsSeparator
    A char used to separate parts in the name, by default "-" is used

    .PARAMETER BreakIfError
    Break function execution if parameters provided for output folder creation are not correct or destination folder path is not writables

    .PARAMETER Force
    If used the function Doesn't ask for an overwrite decission, assumes that the file can be overwritten

    .EXAMPLE

    PS \> (Get-Item env:COMPUTERNAME).Value
    WXDX75

    PS \> $FolderNeeded= @{
        ParentPath = 'C:\USERS\UserName\';
        OutputFolderNamePrefix = 'Messages';
        OutputFolderNameMidPart = (Get-Item env:COMPUTERNAME).Value
        IncludeDateTimePartInOutputFolderName = $false;
        BreakIfError = $true
    }

    PS \> $PerServerReportFolderMessages = New-OutputFolder @FolderNeeded

    PS \> $PerServerReportFolderMessages | Format-List

    OutputFilePath      : C:\users\UserName\Messages-WXDX75
    ExitCode            : 0
    ExitCodeDescription : Everything is fine :-)

    PS \> New-Item -Path $PerServerReportFolderMessages.OutputFolderPath -ItemType Directory

    Directory: C:\USERS\UserName

    Mode                LastWriteTime         Length Name
    ----                -------------         ------ ----
    -a----       21/10/2015     00:12              0 Messages-WXDX75

    The file created on provided parameters.
    Under preparation the file name is created, provided part of names are used, and availability of name (if the file exist now) is checked.

    .EXAMPLE

    $FolderNeeded= @{
        ParentPath = 'C:\USERS\UserName\';
        OutputFolderNamePrefix = 'Messages';
        OutputFolderNameMidPart = 'COMPUTERNAME';
        OutputFolderNameSuffix = "failed"
    }

    PS \> $PerServerReportFolderMessages = New-OutputFolder @FolderNeeded

    PS \> $PerServerReportFolderMessages.OutputFolderPath | Select-Object -Property Name,Parent,exists | Format-List

    Name   : Messages-COMPUTERNAME-20161112-failed
    Parent : UserName
    Exists : False

    PS \> ($PerServerReportFolderMessages.OutputFolderPath).gettype()

    IsPublic IsSerial Name                                     BaseType
    -------- -------- ----                                     --------
    True     True     DirectoryInfo                            System.IO.FileSystemInfo

    PS \> Test-Path ($PerServerReportFolderMessages.OutputFilePath)
    False

    The function return object what contain the property named OutputFilePath what is the object of type System.IO.DirectoryInfo.

    Folder is not created. Only the object in the memory is prepared.

    .OUTPUTS
    System.Object[]

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, Folder, FileSystem

    CURRENT VERSION
    - 0.9.12 - 2018-05-01

    HISTORY OF VERSIONS
    https://github.com/it-praktyk/New-OutputObject/CHANGELOG.md

    LICENSE
    Copyright (c) 2016 Wojciech Sciesinski
    This function is licensed under The MIT License (MIT)
    Full license text: https://opensource.org/licenses/MIT

    #>

    [cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions','')]
    [OutputType([System.Object[]])]
    param (
        [parameter(Mandatory = $false)]
        [String]$ParentPath = ".",
        [parameter(Mandatory = $false)]
        [String]$OutputFolderNamePrefix = "Output",
        [parameter(Mandatory = $false)]
        [String]$OutputFolderNameMidPart = $null,
        [parameter(Mandatory = $false)]
        [String]$OutputFolderNameSuffix = $null,
        [parameter(Mandatory = $false)]
        [Bool]$IncludeDateTimePartInOutputFolderName = $true,
        [parameter(Mandatory = $false)]
        [Nullable[DateTime]]$DateTimePartInOutputFolderName = $null,
        [Parameter(Mandatory = $false)]
        [String]$DateTimePartFormat="yyyyMMdd",
        [parameter(Mandatory = $false)]
        [alias("Separator")]
        [String]$NamePartsSeparator="-",
        [parameter(Mandatory = $false)]
        [Switch]$BreakIfError,
        [parameter(Mandatory = $false)]
        [Switch]$Force
    )

    $params = @{

        ObjectType = 'Folder'

        ParentPath = $ParentPath

        OutputObjectNamePrefix = $OutputFolderNamePrefix

        OutputObjectNameMidPart = $OutputFolderNameMidPart

        OutputObjectNameSuffix = $OutputFolderNameSuffix

        IncludeDateTimePartInOutputObjectName = $IncludeDateTimePartInOutputFolderName

        DateTimePartInOutputObjectName = $DateTimePartInOutputFolderName

        DateTimePartFormat = $DateTimePartFormat

        NamePartsSeparator = $NamePartsSeparator

        BreakIfError = $BreakIfError

        Force = $Force

    }

    $Result = New-OutputObject @params

    Return $Result
}
