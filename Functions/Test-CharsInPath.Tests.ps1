Import-Module ActiveDirectory
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Test-CharsInPath" {
    
    Context "Input is a file or a directory PSObject" {
        
        $TestFile = New-Item -Path "TestDrive:" -Name "TestFile1.txt" -ItemType File
        
        $TestDir = New-Item -Path "TestDrive:" -Name "TestDir1" -ItemType Container
        
        It "Input is a directory, SkipCheckCharsInPath" {
            
            Test-CharsInPath -path $TestDir -SkipCheckCharsInPath | Should Be 1
            
        }
        
        It "Input is a file, SkipCheckCharsInFileName" {
            
            Test-CharsInPath -path $TestFile -SkipCheckCharsInFileName | Should Be 1
            
        }
        
    }
    
    Context "Input is a string" {
        
        [String]$CorrectPathString = 'C:\Windows\Temp\Add-ADGroupMember.ps1'
        
        [String]$InCorrectPathString = 'C:\Windows\Te%mp\Add-ADGroupMember.ps1'
        
        [String]$InCorrectFileNameString = 'C:\Windows\Temp\Add-ADGrou/pMember.ps1'
        
        It "Input is string, CorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString | should be 0
            
        }
            
        It "Input is string, SkipCheckCharsInPath, CorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInPath | should be 0
            
        }
        
        It "Input is string, SkipCheckCharsInFileName, CorrectPathString" {
            
            Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInFileName | should be 0
            
        }
        
        It "Input is string, InCorrectPathString" {
            
            Test-CharsInPath -Path $InCorrectPathString -SkipCheckCharsInPath | should be 2
            
        }
        
        
        It "Input is string, SkipCheckCharsInPath, InCorrectPathString" {
            
            Test-CharsInPath -Path $InCorrectPathString -SkipCheckCharsInPath | should be 2
            
        }
        
        It "Input is string, SkipCheckCharsInFileName, InCorrectPathString" {
            
            Test-CharsInPath -Path $InCorrectPathString -SkipCheckCharsInFileName | should be 2
            
        }
        
    }
    
    #>
}
