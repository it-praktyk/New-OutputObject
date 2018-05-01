# New-OutputObject Module

[![Build Status](https://travis-ci.org/it-praktyk/New-OutputObject.svg?branch=master)](https://travis-ci.org/it-praktyk/New-OutputObject)

## Description and examples of usage

The PowerShell module intended for preparing PowerShell objects what the next help output filesystem objects, means: files and folders.

The module - since version 0.9.10 - is compatible with PowerShell Core 6.0.0.

Using the New-OutputObject you can prepare files/folders names like

- a folder name like: \<MySuperServer>\<\_>\<DailyReport\>\<_\>\<1\>\<\_\>\<20170508\>

```powershell
New-OutputFolder -OutputFolderNamePrefix MySuperServer -OutputFolderNameMidPart DailyReport -OutputFolderNameSuffix 1 -NamePartsSeparator "_" | Format-List

OutputObjectPath    : C:\Users\UserName\Documents\Scripts\1 - GitHub My\New-OutputObject\MySuperServer_DailyReport_20170723_1
OutputFolderPath    : C:\Users\UserName\Documents\Scripts\1 - GitHub My\New-OutputObject\MySuperServer_DailyReport_20170723_1
ExitCode            : 0
ExitCodeDescription : Everything is fine :-)
```

or

- a file name like: \<SuperImportantFile>\<->\<Generated on server>\<->\<SV004>-\<20170508-123400>.\<pdf>

```powershell
New-OutputFile -OutputFileNamePrefix SuperImportantFile -OutputFileNameMidPart "Generated on server" -OutputFileNameSuffix $(Get-Item env:computername).Value -OutputFileNameExtension pdf | Format-List

OutputObjectPath    : C:\Users\Wojtek\Documents\Scripts\1 - GitHub My\New-OutputObject\SuperImportantFile-Generated on server-20170723-173456-TEST-COMPUTER.pdf
OutputFilePath      : C:\Users\Wojtek\Documents\Scripts\1 - GitHub My\New-OutputObject\SuperImportantFile-Generated on server-20170723-173456-TEST-COMPUTER.pdf
ExitCode            : 0
ExitCodeDescription : Everything is fine :-)
```

where any part in "<>" can be provided directly as a parameter of function.

For more examples please use:

- Get-Help New-OutputObject -Examples
- Get-Content -Path .\Demo\Demo.txt

Examples are based on Windows.

Functions from the New-OutputObject module do:

- check if prepared path contains chars what are supported by FileSystem PSProvider
- check if the provided parent path exist
- checks if the provided path is writable
- prepares the file/folder name based on the path, prefix, suffix, date etc.
- checks if the file/folder already exist and display dialog with a warning and a question about overwrite decission
- returns the PowerShell object what contains e.g. [System.IO.FileInfo]

Functions from the New-OutputObject don't

- create file/folder (except that used to check if destination - parent path - is writable but that files/folders are not retained).

## Feedbacks and comments

Your comments - preferable via GitHub issues - and  pull requests are welcomed.

The current module version: 0.9.13 - 2018-05-01.

The history of versions you can find [here](CHANGELOG.md).

The module you can download directly from GitHub or  from the [PowerShellGallery](https://www.powershellgallery.com/packages/New-OutputObject/).

## New-OutputObject Cmdlets

### New-OutputFile

#### SYNOPSIS

Function intended for preparing a PowerShell object for output files like reports or logs.

#### DESCRIPTION

Function intended for preparing a PowerShell custom object what contains e.g. file name for output/create files like reports or log. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.

##### Supported options

|ParameterName|DefaultValue|Remarks|
|:---|:---:|:---|
|ParentPath| .| |
|OutputFileNamePrefix|Output||
|OutputFileNameMidPart|||
|OutputFileNameSuffix|||
|IncludeDateTimePartInOutputFileName|true|||
|DateTimePartInOutputFileName| Get-Date ||
|DateTimePartFormat|yyyyMMdd-HHmmss||
|OutputFileNameExtension|txt||
|NamePartsSeparator|-||
|BreakIfError||If not used for some non critical errors returned object can't be suitable to create file|
|Force||If used the exising objects will be overwirten without questions|

##### Returned object contains properties

|Property name|Property type|Remarks|
|--|--|--|
|OutputObjectPath|[\[System.IO.FileInfo\]](https://msdn.microsoft.com/en-us/library/system.io.fileinfo(v=vs.110).aspx)|For an ExitCode=2 OutputObjectPath is equal null|
|OutputFilePath|[\[System.IO.FileInfo\]](https://msdn.microsoft.com/en-us/library/system.io.fileinfo(v=vs.110).aspx)|alias of OutputFilePath|
|ExitCode|[Int]||
|ExitCodeDescription|[String]||

##### Returned exit codes and descriptions

|Exit code|Description|
|:---:|:---|
|  0  |Everything is fine :-)|
|  1  |Provided path \<PATH> doesn't exist|
|  2  |The result name contains unacceptable chars|
|  3  |Provided patch \<PATH> is not writable|
|  4  |The file \<PATH>\\<FILE_NAME> already exist - can be overwritten|
|  5  |The file \<PATH>\\<FILE_NAME> already exist - can't be overwritten|
|  6  |The file \<PATH>\\<FILE_NAME> already exist - can be overwritten due to used the Force switch|

Detailed help and examples for the New-ObjectFile you can find  [here\](Help/New-OutputFile.md)

### New-OutputFolder

#### SYNOPSIS

Function intended for preparing a PowerShell object for output/create folders for reports logs, etc.

#### DESCRIPTION

Function intended for preparing a PowerShell custom object what contains e.g.folder name for output/create folders. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.

##### Supported options

|ParameterName|DefaultValue|Remarks|
|:---|:---:|:---|
|ParentPath| .\\||
|OutputFolderNamePrefix|Output||
|OutputFolderNameMidPart|||
|OutputFolderNameSuffix|||
|IncludeDateTimePartInOutputFolderName|true|||
|DateTimePartInOutputFolderName| Get-Date ||
|DateTimePartFormat|yyyyMMdd||
|NamePartsSeparator|-||
|BreakIfError||If not used for some non critical errors returned object can't be suitable to create Folder|

###### Returned object contains properties

|Property name|Property type|Remarks|
|--|--|--|
|OutputObjectPath|[\[System.IO.DirectoryInfo\]](https://msdn.microsoft.com/en-us/library/system.io.directoryinfo(v=vs.110).aspx)|For an ExitCode=2 OutputObjectPath is equal null|
|OutputFolderPath|[\[System.IO.DirectoryInfo\]](https://msdn.microsoft.com/en-us/library/system.io.directoryinfo(v=vs.110).aspx)|alias of OutputFolderPath|
|ExitCode|[Int]||
|ExitCodeDescription|[String]||

###### Returned exit codes and descriptions

|Exit code|Description|
|:---:|:---|
|  0  |Everything is fine :-)|
|  1  |Provided parent path \<PATH> doesn't exist|
|  2  |The result name contains unacceptable chars|
|  3  |Provided patch \<PATH> is not writable|
|  4  |The folder \<PATH>\\<FOLDER_NAME> already exist  - can be overwritten|
|  5  |The folder \<PATH>\\<FOLDER_NAME> already exist  - can't be overwritten|
|  6  |The file <PATH>\\<FOLDER_NAME> already exist - can be overwritten due to used the Force switch|

Detailed help and examples for the New-ObjectFolder you can find  [here\](Help/New-OutputFolder.md)

### New-OutputObject

The behaviour of the New-OutputObject is determined by the value of parameter ObjectType what can be: File or Folder. Generally it's a main function, functions New-OutputFile and New-OutputFolder are only proxy to call the New-OutputObject with selected parameter ObjectType.

## LICENSE

Copyright (c) 2016-2018 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
Full license text: https://opensource.org/licenses/MIT

## TODO

For to do and developments plans please check [TODO.md file](TODO.md).
