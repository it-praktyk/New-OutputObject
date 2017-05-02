# New-OutputObject Module

## Description
The PowerShell module intended for preparing PowerShell objects what the next help output filesystem objects, means: files and folders.

The module does:
- checks if the provided path is writable
- prepares the file/folder name based on the path, prefix, suffix, date etc.
- checks if the file/folder already exist and display dialog with a warning and a question about overwrite decission

The module doesn't
- create file/folder (except that used to check if destination is writable but that files are not retained).

Module version: 0.9.7 - 2017-05-02
[History of versions](VERSIONS.md)


## New-OutputObject Cmdlets

### [New-OutputFile](Help/New-OutputFile.md)

#### SYNOPSIS
Function intended for preparing a PowerShell object for output files like reports or logs.

#### DESCRIPTION
Function intended for preparing a PowerShell custom object what contains e.g. file name for output/create files like reports or log. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.

Returned object contains properties

|--|--|--|
|Property name|Property type|Remarks|
|OutputObjectPath|[System.IO.FileInfo]|For an ExitCode=2 OutputObjectPath is equal null|
|OutputFilePath|[System.IO.FileInfo|alias of OutputFilePath|
|ExitCode|[Int]||
|ExitCodeDescription|[String]||


### [New-OutputFolder](Help/New-OutputFolder.md)

#### SYNOPSIS
Function intended for preparing a PowerShell object for output/create folders for e.g. reports or logs.

#### DESCRIPTION
Function intended for preparing a PowerShell custom object what contains e.g.folder name for output/create folders. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.
Returned object contains properties
|Property name|Property type|Remarks|
|OutputObjectPath|[System.IO.FolderInfo]|For an ExitCode=2 OutputObjectPath is equal null|
|OutputFilePath|[System.IO.FolderInfo|alias of OutputFolderPath|
|ExitCode|[Int]||
|ExitCodeDescription|[String]||

## LICENSE
Copyright (c) 2016 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
Full license text: https://opensource.org/licenses/MIT

## TODO
For ToDo and developments plans please check [TODO.md file](TODO.md).

Your comments - preferable via GitHub issues - and  pull requests are welcomed.
