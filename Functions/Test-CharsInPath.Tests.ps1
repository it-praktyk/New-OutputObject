
    
    $here = Split-Path -Parent $MyInvocation.MyCommand.Path
    
    $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
    
    . "$here\$sut"
    
    [Bool]$VerboseFunctionOutput = $false
    
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
            
            [String]$InCorrectPathString = 'C:\Win>dows\Te%mp\Add-ADGroupMember.ps1'
            
            [String]$InCorrectFileNameString = 'C:\Windows\Temp\Ard-ADGrou|p<Member.ps1'
            
            [String]$IncorrectFullPathString = 'C:\Win>dows\Temp\Ard-ADGrou|p<Member.ps1'
            
            It "Input is string, CorrectPathString" {
                
                Test-CharsInPath -Path $CorrectPathString -verbose:$VerboseFunctionOutput | should be 0
                
            }
            
            It "Input is string, SkipCheckCharsInPath, CorrectPathString" {
                
                Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInPath -verbose:$VerboseFunctionOutput | should be 0
                
            }
            
            It "Input is string, SkipCheckCharsInFileName, CorrectPathString" {
                
                Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInFileName -verbose:$VerboseFunctionOutput | should be 0
                
            }
            
            It "Input is string, InCorrectPathString" {
                
                Test-CharsInPath -Path $InCorrectPathString -SkipCheckCharsInPath -verbose:$VerboseFunctionOutput | should be 0
                
            }
            
            
            It "Input is string, SkipCheckCharsInPath, InCorrectPathString" {
                
                Test-CharsInPath -Path $InCorrectPathString -SkipCheckCharsInPath -verbose:$VerboseFunctionOutput | should be 0
                
            }
            
            It "Input is string, SkipCheckCharsInFileName, InCorrectFileNameString" {
                
                Test-CharsInPath -Path $InCorrectFileNameString -SkipCheckCharsInFileName -verbose:$VerboseFunctionOutput | should be 0
                
            }
            
            It "Input is string, InCorrectFileNameString" {
                
                Test-CharsInPath -Path $InCorrectFileNameString -verbose:$VerboseFunctionOutput | should be 3
                
            }
            
            It "Input is string, SkipCheckCharsInPath and SkipCheckCharsInFileName, InCorrectPathString" {
                
                Test-CharsInPath -Path $CorrectPathString -SkipCheckCharsInFileName -SkipCheckCharsInPath -verbose:$VerboseFunctionOutput | should be 1
                
            }
            
        }
        
        Context "Input is other than string of System.IO.X" {
            
            It "Input is Int32" {
                
                [Int]$PathToTest = 23
                
                { Test-CharsInPath -Path $PathToTest -verbose:$VerboseFunctionOutput }  | should Throw
                
            }
            
        }
        
    }
    
