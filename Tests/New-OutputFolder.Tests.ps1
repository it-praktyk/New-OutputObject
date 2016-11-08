<#	

    .SYNOPSIS
    Pester tests for function New-OutputFolder

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, FileSystem, Pester
  
    VERSIONS HISTORY
    - 0.1.0 - 2016-06-10 - Initial release, based on the New-OutputFolder v. 0.8.1
    - 0.2.0 - 2016-06-10 - The parameter for a folder prefix removed, Pester test added 
    - 0.3.0 - 2016-06-10 - The first tests still failed :-), Mock failed also

#>

$ModuleName = "New-OutputObject"

#Provided path asume that your module manifest (a file with the psd1 extension) exists in the parent directory for directory where the current test script is stored
$RelativePathToModuleManifest = "{0}\..\{1}.psd1" -f $PSScriptRoot, $ModuleName

#Remove module if it's currently loaded 
Get-Module -Name $ModuleName -ErrorAction SilentlyContinue | Remove-Module

Import-Module -FullyQualifiedName $RelativePathToModuleManifest -Force -Scope Global

$FunctionName = "New-OutputFolder"

[Bool]$VerboseFunctionOutput = $true


Describe "New-OutputFolder" {
    
    
    $LocationAtBegin = Get-Location
    
    Set-Location TestDrive:
    
    Context "Function $FunctionName - run without parameters" {
        
        Mock -ModuleName $ModuleName -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $Result = New-OutputFolder
        
        It "Function $FunctionName - run without parameters - OutputFilePath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - run without parameters - OutputFilePath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108"
        }
        
        
        It "Function $FunctionName - run without parameters - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - run without parameters - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
        
    }
    
    Set-Location $LocationAtBegin
}
