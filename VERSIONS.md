# History of versions for New-OutputObject Module

- 0.9.0 - 2016-11-07 - the first release as a module 
- 0.9.1 - 2016-11-08 - global tests added, basic test for functions added, small corrections in main functions
- 0.9.2 - 2016-11-11 
    - New-OutputObject v. 0.1.0
    - New-OutputFile v. 0.9.1
    - New-OutputFolder v. 0.3.0
    - Test-CharsInPath v. 0.5.2
    - New-OutputFile.Tests v. 0.2.0
    - New-OutputFolder.Tests v. 0.4.0
    - Test-CharsInPath.Tests v. 0.5.0
- 0.9.3 - 2016-11-12
    - New-OutputObject v. 0.1.0
    - New-OutputFile v. 0.9.2
    - New-OutputFolder v. 0.3.1
    - Test-CharsInPath v. 0.5.2
    - New-OutputFile.Tests v. 0.2.0
    - New-OutputFolder.Tests v. 0.4.0
    - Test-CharsInPath.Tests v. 0.5.0
- 0.9.4 - 2016-11-12
    - New-OutputObject v. 0.1.0
    - New-OutputFile v. 0.9.3
    - New-OutputFolder v. 0.3.2
    - Test-CharsInPath v. 0.5.2
    - Get-OverwriteDecision v. 0.1.0
    - New-OutputFile.Tests v. 0.3.0
    - New-OutputFolder.Tests v. 0.5.0
    - Test-CharsInPath.Tests v. 0.5.0
- 0.9.5 - 2016-11-13
    - New-OutputObject v. 0.2.0
	- New-OutputFile v. 0.9.3
    - New-OutputFolder v. 0.3.2
    - Test-CharsInPath v. 0.5.2
    - Get-OverwriteDecision v. 0.1.0
    - New-OutputFile.Tests v. 0.3.0
    - New-OutputFolder.Tests v. 0.5.0
    - Test-CharsInPath.Tests v. 0.5.0
	

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

## Function New-OutputFolder
- 0.1.0 - 2016-06-10 - Initial release, based on the New-OutputFile v. 0.8.1
- 0.2.0 - 2016-06-10 - The parameter for a folder prefix removed
- 0.2.1 - 2016-11-07 - Help updated, the function version moved to VERSION.md file 
- 0.2.2 - 2016-11-07 - Help updated, the TODO list moved to TODO.md file, declared OUTPUTS
- 0.3.0 - 2016-11-11 - The parameter OutputFolderDirectoryPath renamed to ParentFolder, type of the parameter BreakIfError changed, help updated, behaviour of function with provided OutputFolderNameSuffix parameter corrected
- 0.3.1 - 2016-11-12 - behaviour for existing folders corrected
- 0.3.2 - 2016-11-12 - help updated, part of a code moved to Get-OverwriteDecision, section for existing folders corrected

## Function Test-CharsInPath
- 0.1.0 - 2016-06-06 - Initial release
- 0.2.0 - 2016-06-06 - The second draft, Pester tests updated
- 0.3.0 - 2016-06-07 - The first working version :-)
- 0.4.0 - 2016-06-08 - The logic of function corrected, test expanded
- 0.5.0 - 2016-06-08 - Checking of Path provided as an PSObjects corrected, SkipCheck* parameters renamed, help updated
- 0.5.1 - 2016-06-10 - Named blocks of code added
- 0.5.2 - 2016-11-08 - Help updated, the TODO list moved to TODO.md file, history of version moved to VERSION.md file 

## Function Get-OverwriteDecision
- 0.1.0 - 2016-11-12 - Initial version

## New-OutputObject.Tests
- 0.1.0 - 2016-11-07 - The first version of tests
- 0.1.1 - 2016-11-11 - The tests versions history moved to VERSION.md file, help updated

## New-OutputFile.Tests
- 0.1.0 - 2016-11-07 - the first version of tests
- 0.2.0 - 2016-11-11 - tests updated and extended, help updated
- 0.3.0 - 2016-11-12 - tests for scenarios with existing folders added

## New-OutputFolder.Tests
- 0.1.0 - 2016-06-10 - Initial release, based on the New-OutputFile v. 0.8.1
- 0.2.0 - 2016-06-10 - The parameter for a folder prefix removed, Pester test added 
- 0.3.0 - 2016-06-10 - The first tests still failed :-), Mock failed also
- 0.4.0 - 2016-11-11 - tests updated and extended, help updated
- 0.5.0 - 2016-11-12 - correction of renamed parameters, tests for scenarios with existing folders added

## Test-CharsInPath.Tests
- 0.5.0 - 2016-11-11 - The tests versions history moved to VERSION.md file, help updated