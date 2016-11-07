# New-OutputObject Module
## Description
The PowerShell module intended for preparing PowerShell objects what help output filesystem objects (files and folders).

The module does:
- checks if the provided path is writable
- prepares the file/folder name based on the path, prefixes, suffixes, etc.
- checks if the file/folder already exist and display dialog with warning and question about decission

Module version: 0.9.0 - 2016-11-07

## New-OutputObject Cmdlets

### [New-OutputFile](Help\New-OutputFile.md)

#### SYNOPSIS
Function intended for preparing a PowerShell object for output files like reports or logs.

#### DESCRIPTION
Function intended for preparing a PowerShell custom object what contains e.g. file name for output/create files like reports or log. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.

Returned object contains properties
- OutputFilePath - to use it please check examples - as a [System.IO.FileInfo]
- ExitCode
- ExitCodeDescription
	

### [New-OutputFolder](Help\New-OutputFolder.md)
Function intended for preparing a PowerShell object for output/create folders for e.g. reports or logs.

#### SYNOPSIS
Function intended for preparing a PowerShell object for output/create folders for e.g. reports or logs.

#### DESCRIPTION
Function intended for preparing a PowerShell custom object what contains e.g.folder name for output/create folders. The name is prepared based on prefix, middle name part, suffix, date, etc. with verification if provided path exist and is it writable.
Returned object contains properties
- OutputFolderPath - to use it please check an examples - as a [System.IO.FolderInfo]
- ExitCode
- ExitCodeDescription

## LICENSE
Copyright (c) 2016 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
Full license text: https://opensource.org/licenses/MIT
