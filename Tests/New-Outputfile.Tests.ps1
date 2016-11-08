<#

.SYNOPSIS
Pester tests to validate the New-OutputFile.ps1 function

.LINK
https://github.com/it-praktyk/New-OutputObject

.NOTES
AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
KEYWORDS: PowerShell, Pester, psd1, New-OutputFile, New-OutputObject

VERSIONS HISTORY
0.1.0 - 2016-11-07 - The first version of tests

#>

$ModuleName = "New-OutputObject"

#Provided path asume that your module manifest (a file with the psd1 extension) exists in the parent directory for directory where the current test script is stored
$RelativePathToModuleManifest = "{0}\..\{1}.psd1" -f $PSScriptRoot, $ModuleName

#Remove module if it's currently loaded 
Get-Module -Name $ModuleName -ErrorAction SilentlyContinue | Remove-Module

Import-Module -FullyQualifiedName $RelativePathToModuleManifest -Force -Scope Global

$FunctionName = "New-OutputFile"

Describe "Tests for $FunctionName" {
    
    $LocationAtBegin = Get-Location
    
    Set-Location TestDrive:
    
    Context "Function $FunctionName - run without parameters" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile
        
        It "Function $FunctionName - run without parameters - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - run without parameters - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161108-000002.txt"
        }
        
        
        It "Function $FunctionName - run without parameters - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - run without parameters - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
        
    }
    
    
    
    Set-Location -Path $LocationAtBegin
}


