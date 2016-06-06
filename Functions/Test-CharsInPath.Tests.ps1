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
    <#
    Context "Input is a string" {
        
        It
        
    }
    
    #>
}
