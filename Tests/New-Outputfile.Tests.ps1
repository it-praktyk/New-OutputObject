<#

    .SYNOPSIS
    Pester tests to validate the New-OutputFile.ps1 function

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net  
    KEYWORDS: PowerShell, Pester, psd1, New-OutputFile, New-OutputObject  

    CURRENT VERSION
    - 0.2.0 - 2016-11-11

    HISTORY OF VERSIONS  
    https://github.com/it-praktyk/New-OutputObject/VERSIONS.md

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
    
    $ContextName = "run without parameters"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile
        
        It "Function $FunctionName - $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161108-000002.txt"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
        
    }
    
    $ContextName = "run with OutputFileNamePrefix"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile -OutputFileNamePrefix "AAA"
        
        It "Function $FunctionName - $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "AAA-20161108-000002.txt"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with OutputFileNameMidPart"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile -OutputFileNameMidPart "BBB"
        
        It "Function $FunctionName - $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-BBB-20161108-000002.txt"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with OutputFileNameSuffix"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile -OutputFileNameSuffix "CCC"
        
        It "Function $FunctionName - $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161108-000002-CCC.txt"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    
    $ContextName = "run with DateTimePartInOutputFileName"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFile -DateTimePartInOutputFileName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss")
        
        It "Function $FunctionName - $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161101-120001.txt"
        }
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with DateTimePartInOutputFileName, without DateTimePar"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFile -DateTimePartInOutputFileName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss") -IncludeDateTimePartInOutputFileName:$false
        
        It "Function $FunctionName - $ContextName - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output.txt"
        }
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with OutputFileNameExtension"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile -OutputFileNameExtension "csv"
        
        It "Function $FunctionName - $ContextName - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161108-000002.csv"
        }
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with NamePartsSeparator"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile -NamePartsSeparator "_"
        
        It "Function $FunctionName - $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output_20161108-000002.txt"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
        
    }
    
    $ContextName = "run with all name parts, with DateTimePartInOutputFileName"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFile -OutputFileNamePrefix "AAA" -OutputFileNameMidPart "BBB" -OutputFileNameSuffix "CCC" -DateTimePartInOutputFileName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss")
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "AAA-BBB-20161101-120001-CCC.txt"
        }
        
        It "Function $FunctionName -  $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName -  $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with all name parts, without DateTimePart"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFile -OutputFileNamePrefix "AAA" -OutputFileNameMidPart "BBB" -OutputFileNameSuffix "CCC" -DateTimePartInOutputFileName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss") -IncludeDateTimePartInOutputFileName:$false
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "AAA-BBB-CCC.txt"
        }
        
        It "Function $FunctionName -  $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName -  $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run without parameters, non existing destination directory."
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $ParentPath = "TestDrive:\TestFolder"
        
        $Result = New-OutputFile -ParentPath $ParentPath
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161108-000002.txt"
        }
        
        It "Function $FunctionName -  $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 1
        }
        
        It "Function $FunctionName -  $ContextName - exit code description" {
            
            [System.String]$RequiredMessage = "Provided path {0} doesn't exist" -f $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$ParentPath")
            
            $Result.ExitCodeDescription | Should Be $RequiredMessage
        }
    }
    
    $ContextName = "run with existing, non writable destination folder."
    
    Context "Function $FunctionName - $ContextName" {
        
        $TestDestinationFolder = "TestDrive:\ExistingNotWritable\"
        
        New-Item -Path $TestDestinationFolder -ItemType Container | Out-Null
        
        $ChangedACL = $OriginalAcl = Get-Acl -Path $TestDestinationFolder
        
        $colRights = [System.Security.AccessControl.FileSystemRights]"AppendData,WriteData"
        
        $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None
        
        $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::InheritOnly
        
        $objType = [System.Security.AccessControl.AccessControlType]::Deny
        
        $objUser = New-Object System.Security.Principal.NTAccount($(whoami))
        
        $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule ($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType)
        
        $ChangedACL.AddAccessRule($objACE)
        
        Set-ACL -Path $TestDestinationFolder $ChangedACL
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        $Result = New-OutputFile -ParentPath $TestDestinationFolder
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - an object type" {
            
            $Result.OutputFilePath | Should BeOfType System.Io.FileInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - Name " {
            
            $Result.OutputFilePath.Name | Should Be "Output-20161108-000002.txt"
        }
        
        It "Function $FunctionName -  $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 3
        }
        
        It "Function $FunctionName -  $ContextName - exit code description" {
            
            [System.String]$RequiredMessage = "Provided path {0} is not writable" -f $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestDestinationFolder")
            
            $Result.ExitCodeDescription | Should Be $RequiredMessage
        }
    }
    
    $ContextName = "run with existing, non writable destination folder, break on error"
    
    Context "Function $FunctionName - $ContextName" {
        
        $TestDestinationFolder = "TestDrive:\ExistingNotWritable\"
        
        New-Item -Path $TestDestinationFolder -ItemType Container | Out-Null
        
        $ChangedACL = $OriginalAcl = Get-Acl -Path $TestDestinationFolder
        
        $colRights = [System.Security.AccessControl.FileSystemRights]"AppendData,WriteData"
        
        $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None
        
        $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::InheritOnly
        
        $objType = [System.Security.AccessControl.AccessControlType]::Deny
        
        $objUser = New-Object System.Security.Principal.NTAccount($(whoami))
        
        $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule ($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType)
        
        $ChangedACL.AddAccessRule($objACE)
        
        Set-ACL -Path $TestDestinationFolder $ChangedACL
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }
        
        It "Function $FunctionName -  $ContextName - OutputFilePath - an object type" {
            
            { $Result = New-OutputFile -ParentPath $TestDestinationFolder -BreakIfError } | Should Throw
        }
        
    }
    
    Set-Location -Path $LocationAtBegin
}


