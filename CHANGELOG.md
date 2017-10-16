# History of versions for New-OutputObject Module

- 0.9.0 - 2016-11-07 - the first release as a module
- 0.9.1 - 2016-11-08 - global tests added, basic test for functions added, small corrections in main functions
- 0.9.2 - 2016-11-11
  - New-OutputObject                        v. 0.1.0
  - New-OutputFile                          v. 0.9.1
  - New-OutputFolder                        v. 0.3.0
  - Test-CharsInPath                        v. 0.5.2
  - New-OutputFile.Tests                    v. 0.2.0
  - New-OutputFolder.Tests                  v. 0.4.0
  - Test-CharsInPath.Tests                  v. 0.5.0
- 0.9.3 - 2016-11-12
  - New-OutputObject                        v. 0.1.0
  - New-OutputFile                          v. 0.9.2
  - New-OutputFolder                        v. 0.3.1
  - Test-CharsInPath                        v. 0.5.2
  - New-OutputFile.Tests                    v. 0.2.0
  - New-OutputFolder.Tests                  v. 0.4.0
  - Test-CharsInPath.Tests                  v. 0.5.0
- 0.9.4 - 2016-11-12
  - New-OutputObject                        v. 0.1.0
  - New-OutputFile                          v. 0.9.3
  - New-OutputFolder                        v. 0.3.2
  - Test-CharsInPath                        v. 0.5.2
  - Get-OverwriteDecision                   v. 0.1.0
  - New-OutputFile.Tests                    v. 0.3.0
  - New-OutputFolder.Tests                  v. 0.5.0
  - Test-CharsInPath.Tests                  v. 0.5.0
- 0.9.5 - 2016-11-13
  - New-OutputObject                        v. 0.2.0
  - New-OutputFile                          v. 0.9.3
  - New-OutputFolder                        v. 0.3.2
  - Test-CharsInPath                        v. 0.5.2
  - Get-OverwriteDecision                   v. 0.1.0
  - New-OutputFile.Tests                    v. 0.3.0
  - New-OutputFolder.Tests                  v. 0.5.0
  - Test-CharsInPath.Tests                  v. 0.5.0
- 0.9.6 - 2016-11-13
  - New-OutputObject                        v. 0.2.0
  - New-OutputFile                          v. 0.9.4
  - New-OutputFolder                        v. 0.3.3
  - Test-CharsInPath                        v. 0.5.2
  - Get-OverwriteDecision                   v. 0.1.0
  - New-OutputFile.Tests                    v. 0.3.1
  - New-OutputFolder.Tests                  v. 0.5.1
  - Test-CharsInPath.Tests                  v. 0.5.0
- 0.9.7 - 2017-05-02
  - New-OutputObject                        v. 0.9.7
  - New-OutputFile                          v. 0.9.7
  - New-OutputFolder                        v. 0.9.7
  - Test-CharsInPath                        v. 0.5.3
  - Get-OverwriteDecision                   v. 0.1.1
  - New-OutputObject-Module-Specific.Tests  v. 0.9.7
  - New-OutputObject.Tests                  v. 0.9.7
  - Test-CharsInPath.Tests                  v. 0.5.3
- 0.9.8 - 2017-05-06
  - New-OutputObject                        v. 0.9.8
  - New-OutputFile                          v. 0.9.8
  - New-OutputFolder                        v. 0.9.8
  - Test-CharsInPath                        v. 0.5.3
  - Get-OverwriteDecision                   v. 0.1.1
  - New-OutputObject-Module-Specific.Tests  v. 0.9.8
  - New-OutputObject.Tests                  v. 0.9.7
  - Test-CharsInPath.Tests                  v. 0.5.3
- 0.9.9 - 2017.05-15
  - New-OutputObject                        v. 0.9.9
  - New-OutputFile                          v. 0.9.9
  - New-OutputFolder                        v. 0.9.9
  - Test-CharsInPath                        v. 0.5.4
  - Get-OverwriteDecision                   v. 0.1.1
  - New-OutputObject-Module-Specific.Tests  v. 0.9.8
  - New-OutputObject.Tests                  v. 0.9.7
  - Test-CharsInPath.Tests                  v. 0.5.3
- 0.9.10 - 2017-07-23
  - New-OutputObject                        v. 0.9.10
  - New-OutputFile                          v. 0.9.10
  - New-OutputFolder                        v. 0.9.10
  - Test-CharsInPath                        v. 0.6.1
  - Get-OverwriteDecision                   v. 0.1.2
  - New-OutputObject-Module-Specific.Tests  v. 0.9.8
  - New-OutputObject.Tests                  v. 0.9.10
  - Test-CharsInPath.Tests                  v. 0.5.3
- 0.9.11 - 2017-10-16
  - New-OutputObject                        v. 0.9.11
  - New-OutputFile                          v. 0.9.10
  - New-OutputFolder                        v. 0.9.10
  - Test-CharsInPath                        v. 0.7.0
  - Get-OverwriteDecision                   v. 0.1.2
  - New-OutputObject-Module-Specific.Tests  v. 0.9.11
  - New-OutputObject.Tests                  v. 0.9.11
  - Test-CharsInPath.Tests                  v. 0.7.0

## General

- 0.9.6 - 2016-11-13
  - Demo file added, description in psd1 updated
- 0.9.7 - 2017-05-02
  - General logic moved to the function New-OutputObject
  - Functions New-OutputFile, New-OutputFolder transformed as wrappers for New-OutputObject
  - Version numbers of main functions alligned to the module version
  - Code reformatted (trailings spaces removed, tabs)
  - Pester tests to general validation of the New-OutputObject module - e.g. help, PSScriptAnalyzer results, style rules - moved from New-OutputObject.Tests to New-OutputObject-Module-Specific.Tests
  - The version number of module-wide tests (New-OutputObject-Module-Specific.Tests.ps1) alligned to the module version
  - Tests for New-OutputFile.Tests and New-OutputFolder.Tests merged in New-OutputObject.Tests
- 0.9.8 - 2017-05-06
  - TODO updated
  - unneeded code in the New-OutputObject removed
  - description for ExitCode = 1 little changed
  - message about ignoring extension for folders corrected
- 0.9.9 - 2017-05-15
  - Test-CharsInPath - functions work correctly even if StrictMode is on - fix #2
  - skiping inadequate PScriptAnalyzer rule (PSUseShouldProcessForStateChangingFunctions) implemented better
- 0.9.10 - 2017-07-23
  - Module compatibility with PowerShell Core 6.0.0 beta 4 achieved - tested on Fedora Linux 25, MacOS 10.12, Windows 10
- 0.9.11 - 2017-10-16
  - Module can run when Set-StrictMode -Value Latest is set
  - Compatibility with PowerShell Core 6.0 beta 8

## Function New-OutputObject

- 0.9.7 - 2017-05-02
  - All logic moved from New-OutputFile and New-OutputFolder
  - Checks for unsupported chars added - exit code 2 used for that
  - Returned object extended
- 0.9.8 - 2017-05-06
  - veryfing case what never occurs for user overwrited decission removed
  - description for ExitCode = 1 little changed
  - message about ignoring extension for folders corrected
- 0.9.9 - 2017-05-16 - skiping inadequate PScriptAnalyzer rule implemented better
- 0.9.10 - 2017-07-23
  - Support for PowerShell Core 6.0.0 beta 4 added
  - Logic of preparing and merging of finale name rewritten
  - Reference to VERSIONS.md changed to CHANGELOG.md
- 0.9.11 - 2017.10.16
  - The function can run when Set-StrictMode -Value Latest is set
  - Compatibility with PowerShell Core 6.0 beta 8


## Function New-OutputFile

- 0.1.0 - 2015-09-01 - Initial release
- 0.1.1 - 2015-09-01 - Minor update
- 0.2.0 - 2015-09-08 - Corrected, function renamed to New-OutputFile from New-ReportFileNameFullPath
- 0.3.0 - 2015-09-13 - implementation for DateTimePartInFileName parameter corrected, help updated, some parameters renamed
- 0.4.0 - 2015-10-20 - additional OutputFileNameSuffix parameter added, help updated, TODO updated
- 0.4.1 - 2015-10-21 - help corrected
- 0.5.0 - 2015-10-22 - Returned OutputFilePath changed to type [System.IO.FileInfo], help updated
- 0.6.0 - 2016-01-04 - The function renamed from New-OutputFileNameFullPath to New-OutputFile, help and TODO updated
- 0.7.0 - 2016-06-04 - The license changed to MIT, a code reformatted
- 0.8.0 - 2016-06-05 - The parameter ErrorIfOutputFileExist removed, dialog about replacing existing files added
- 0.8.1 - 2016-06-06 - Help updated
- 0.8.2 - 2016-06-10 - Help updated
- 0.8.3 - 2016-11-07 - Help updated, the function versions history moved to VERSION.md file
- 0.8.4 - 2016-11-08 - Help updated, the TODO list moved to TODO.md file
- 0.9.0 - 2016-11-08 - The parameter CreateOutputFileDirectory removed
- 0.9.1 - 2016-11-11 - The parameter OutputFileDirectoryPath renamed to ParentFolder, type of the parameter BreakIfError changed, help updated
- 0.9.2 - 2016-11-12 - behaviour for existing files corrected
- 0.9.3 - 2016-11-12 - help updated, comments in code updated, part of a code moved to Get-OverwriteDecision
- 0.9.4 - 2016-11-13 - unnecessary message has been deleted, behaviour for existing files corrected
- 0.9.7 - 2017-05-02 - The function transformed to a wrapper for the function New-OutputObject
- 0.9.8 - 2017-05-06 - Help updated due to change of description for the ExcitCode = 1, default value for the parameter DateTimePartFormat declared
- 0.9.9 - 2017-05-16 - skiping inadequate PScriptAnalyzer rule implemented better
- 0.9.10 - 2017-07-23 - Reference to VERSIONS.md changed to CHANGELOG.md

## Function New-OutputFolder

- 0.1.0 - 2016-06-10 - Initial release, based on the New-OutputFile v. 0.8.1
- 0.2.0 - 2016-06-10 - The parameter for a folder prefix removed
- 0.2.1 - 2016-11-07 - Help updated, the function version moved to VERSION.md file
- 0.2.2 - 2016-11-07 - Help updated, the TODO list moved to TODO.md file, declared OUTPUTS
- 0.3.0 - 2016-11-11 - The parameter OutputFolderDirectoryPath renamed to ParentFolder, type of the parameter BreakIfError changed, help updated, behaviour of function with provided OutputFolderNameSuffix parameter corrected
- 0.3.1 - 2016-11-12 - behaviour for existing folders corrected
- 0.3.2 - 2016-11-12 - help updated, part of a code moved to Get-OverwriteDecision, section for existing folders corrected
- 0.3.3 - 2016-11-13 - behaviour for existing folders corrected
- 0.9.7 - 2017-05-02 - The function transformed to a wrapper for the function New-OutputObject
- 0.9.8 - 2017-05-06 - Help updated due to change of description for the ExcitCode = 1, default value for the parameter DateTimePartFormat declared
- 0.9.9 - 2017-05-16 - An unused parameter removed - fix #2, skiping inadequate PScriptAnalyzer rule implemented better
- 0.9.10 - 2017-07-23 - Reference to VERSIONS.md changed to CHANGELOG.md

## Function Test-CharsInPath

- 0.1.0 - 2016-06-06 - Initial release
- 0.2.0 - 2016-06-06 - The second draft, Pester tests updated
- 0.3.0 - 2016-06-07 - The first working version :-)
- 0.4.0 - 2016-06-08 - The logic of function corrected, test expanded
- 0.5.0 - 2016-06-08 - Checking of Path provided as an PSObjects corrected, SkipCheck* parameters renamed, help updated
- 0.5.1 - 2016-06-10 - Named blocks of code added
- 0.5.2 - 2016-11-08 - Help updated, the TODO list moved to TODO.md file, history of version moved to VERSION.md file
- 0.5.3 - 2017-05-02 - Code reformatted
- 0.5.4 - 2017-05-16 - Works when Set-StrictMode is on - fix #2
- 0.6.0 - 2017-07-15
  - Support for PowerShell Core 6.0.0 beta 4 added
  - The parameter SkipDividingForParts added
- 0.6.1 - 2017-07-23 - Reference to VERSIONS.md changed to CHANGELOG.md
- 0.7.0 - 2017-10-16
  - The function can run when Set-StrictMode -Value Latest is set
  - Compatibility with PowerShell Core 6.0 beta 8
  - The structure corrected - thanks Iain Brighton!

## Function Get-OverwriteDecision

- 0.1.0 - 2016-11-12 - Initial version
- 0.1.1 - 2017-05-02 - Code reformatted
- 0.1.2 - 2017-07-23 - Reference to VERSIONS.md changed to CHANGELOG.md

## New-OutputObject-Module-Specific.Tests

- 0.1.0 - 2016-11-07 - The first version of tests
- 0.1.1 - 2016-11-11 - The tests versions history moved to VERSION.md file, help updated
- 0.9.7 - 2017-05-02
  - Pester tests to general validation of the New-OutputObject module - e.g. help, PSScriptAnalyzer results, style rules - moved from New-OutputObject.Tests to New-OutputObject-Module-Specific.Tests
  - Tests for style rules - based on style rules for the Pester module itself - added
- 0.9.8 - 2017-05-16 - skiping some PScriptAnalyzer rules moved to functions
- 0.9.10 - 2017-07-23
  - Code reformatted, minor updates
  - Reference to VERSIONS.md changed to CHANGELOG.md
- 0.9.11 - 2017-10-16
  - The function can run when Set-StrictMode -Value Latest is set
  - Compatibility with PowerShell Core 6.0 beta 8
  - folder separators generalized to support differences between Windows/Linux/macOS

## New-OutputObject.Tests

- 0.9.7 - 2017-05-02
  - Tests for New-OutputFile.Tests and New-OutputFolder.Tests merged
  - Scope of tests extended and mostly rewritten
- 0.9.8 - 2017-05-06 - Help updated due to change of description for the ExcitCode = 1
- 0.9.9 - 2017-07-15 - Support for PowerShell Core 6.0.0 beta 4 added
- 0.9.10 - 2017-07-23
  - Code reformatted
  - Reference to VERSIONS.md changed to CHANGELOG.md
  - Support for PowerShell Core 6.0.0 beta 4 on Windows corrected
- 0.9.11 - 2017-10-16
  - The function can run when Set-StrictMode -Value Latest is set
  - Compatibility with PowerShell Core 6.0 beta 8
  - folder separators generalized to support differences between Windows/Linux/macOS

## Test-CharsInPath.Tests

- 0.5.0 - 2016-11-11 - The tests versions history moved to VERSION.md file, help updated
- 0.5.1 - 2017-05-02 - Code reformatted
- 0.6.0 - 2017-07-03 - Support for PowerShell Core 6.0.0 beta 4 added
- 0.6.1 - 2017-07-23
  - Code reformatted
  - Reference to VERSIONS.md changed to CHANGELOG.md
  - Support for PowerShell Core 6.0.0 beta 4 on Windows corrected
- 0.7.0 - 2017-11-16
  - The function can run when Set-StrictMode -Value Latest is set
  - Compatibility with PowerShell Core 6.0 beta 8
  - folder separators generalized to support differences between Windows/Linux/macOS
