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

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

[Bool]$VerboseFunctionOutput = $true


Describe "New-OutputFolder" {
    
    Context "Test for OutputFolderDirectoryPath" {
        
        $TestOutputFolderDirectoryPath = New-Item -Path "TestDrive:\Outputs"
        
        It "OutputFolderDirectoryPath exist" {
            
            $((($FinalFunctionOutput = New-OutputFolder -$OutputFolderDirectoryPath $TestOutputFolderDirectoryPath).OutputFolderPath).Name) -eq "Output" | Should Be $true
        }
        
    }
}
