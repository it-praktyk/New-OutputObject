<#	

    .SYNOPSIS
    Pester tests for function Test-CharsInPath

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, FileSystem, Pester
  
    VERSIONS HISTORY
    - 0.1.0 - 2016-06-06 - Initial release
    - 0.2.0 - 2016-06-06 - The second draft, Pester tests updated
    - 0.3.0 - 2016-06-07 - The first working version :-)
    - 0.4.0 - 2016-06-08 - Test expanded

#>


$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

. "$here\$sut"

[Bool]$VerboseFunctionOutput = $false

Describe "Test-CharsInPath" {
    
    Context "Input is a file or a directory PSObject" {
        
        $TestFile = New-Item -Path "TestDrive:" -Name "TestFile1.txt" -ItemType File
        
        $TestDir = New-Item -Path "TestDrive:" -Name "TestDir1" -ItemType Container
        
        It "Input is a directory, SkipCheckCharsInFolderPart" {
            
            Test-CharsInPath -path $TestDir -SkipCheckCharsInFolderPart | Should Be 1
            
        }
        
        It "Input is a file, SkipCheckCharsInFileNamePart" {
            
            Test-CharsInPath -path $TestFile -SkipCheckCharsInFileNamePart | Should Be 1
            
        }
        
    }
    
    Context "Input is a string" {
        
        [String]$CorrectPathString = 'C:\Windows\Temp\Add-GroupsMember.ps1'
        
        [String]$InCorrectPathString = 'C:\Win>dows\Te%mp\Add-ADGroupMember.ps1'
        
        [String]$InCorrectFileNameString = 'C:\Windows\Temp\Ard-ADGrou|p<Member.ps1'
        
        [String]$IncorrectFullPathString = 'C:\Win>dows\Temp\Ard-ADGrou|p<Member.ps1'
        
        [String]$IncorrectDirectoryOnly = 'C:\AppData\Loc>al\'
        
        [String]$CorrectDirectoryOnly = 'C:\AppData\Local\'
        
        [String]$IncorrectFileNameOnly = 'Test-File-201606*08-1315.txt'
        
        [String]$CorrectFileNameOnly = 'Test-File-20160608-1315.txt'
        
        It "Input is string, CorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString -verbose:$VerboseFunctionOutput | should be 0
            
        }
        
        It "Input is string, SkipCheckCharsInFolderPart, CorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInFolderPart -verbose:$VerboseFunctionOutput | should be 0
            
        }
        
        It "Input is string, SkipCheckCharsInFileNamePart, CorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInFileNamePart -verbose:$VerboseFunctionOutput | should be 0
            
        }
        
        It "Input is string, SkipCheckCharsInFolderPart, IncorrectDirectoryOnly" {
            
            Test-CharsInPath -Path $IncorrectDirectoryOnly -SkipCheckCharsInFolderPart -verbose:$VerboseFunctionOutput | should be 1
            
        }
        
        It "Input is string, IncorrectDirectoryOnly" {
            
            Test-CharsInPath -Path $IncorrectDirectoryOnly  -verbose:$VerboseFunctionOutput | should be 2
            
        }
        
        It "Input is string, CorrectDirectoryOnly only" {
            
            Test-CharsInPath -Path $CorrectDirectoryOnly -verbose:$VerboseFunctionOutput | should be 0
            
        }
        
        
        It "Input is string, SkipCheckCharsInFileNamePart, InCorrectFileNameString" {
            
            Test-CharsInPath -Path $InCorrectFileNameString -SkipCheckCharsInFileNamePart -verbose:$VerboseFunctionOutput | should be 0
            
        }
        
        It "Input is string, InCorrectFileNameString" {
            
            Test-CharsInPath -Path $InCorrectFileNameString -verbose:$VerboseFunctionOutput | should be 3
            
        }
        
        It "Input is string, SkipCheckCharsInFileNamePart, IncorrectFileNameOnly" {
            
            Test-CharsInPath -Path $IncorrectFileNameOnly -SkipCheckCharsInFileNamePart -verbose:$VerboseFunctionOutput | should be 1
            
        }
        
        It "Input is string, IncorrectFileNameOnly only" {
            
            Test-CharsInPath -Path $IncorrectFileNameOnly -verbose:$VerboseFunctionOutput | should be 3
            
        }
        
        It "Input is string, SkipCheckCharsInFileNamePart, CorrectFileNameOnly" {
            
            Test-CharsInPath -Path $CorrectFileNameOnly -SkipCheckCharsInFileNamePart -verbose:$VerboseFunctionOutput | should be 1
            
        }
        
        It "Input is string, CorrectFileNameOnly only" {
            
            Test-CharsInPath -Path $CorrectFileNameOnly -verbose:$VerboseFunctionOutput | should be 0
            
        }
        
        It "Input is string, SkipCheckCharsInFolderPart and SkipCheckCharsInFileNamePart, InCorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInFileNamePart -SkipCheckCharsInFolderPart -verbose:$VerboseFunctionOutput | should be 1
            
        }
        
        
        
    }
    
    Context "Input is other than string or System.IO.X" {
        
        It "Input is Int32" {
            
            [Int]$PathToTest = 23
            
            { Test-CharsInPath -Path $PathToTest -verbose:$VerboseFunctionOutput } | should Throw
            
        }
        
    }
    
}

