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
  
    CURRENT VERSION
    - 0.5.0 - 2016-11-12

    HISTORY OF VERSIONS  
    https://github.com/it-praktyk/New-OutputObject/VERSIONS.md
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
        
        It "Function $FunctionName - run without parameters - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - run without parameters - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108"
        }
        
        
        It "Function $FunctionName - run without parameters - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - run without parameters - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
        
    }
    
    $ContextName = "run with OutputFolderNamePrefix"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $Result = New-OutputFolder -OutputFolderNamePrefix "AAA"
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "AAA-20161108"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with OutputFolderNameMidPart"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $Result = New-OutputFolder -OutputFolderNameMidPart "BBB"
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-BBB-20161108"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with OutputFolderNameSuffix"
    
    Context "Function $FunctionName - $ContextName" {
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $Result = New-OutputFolder -OutputFolderNameSuffix "CCC"
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108-CCC"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    
    $ContextName = "run with DateTimePartInOutputFolderName"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFolder -DateTimePartInOutputFolderName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss")
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161101"
        }
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
    }
    
    $ContextName = "run with DateTimePartInOutputFolderName, without DateTimePar"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFolder -DateTimePartInOutputFolderName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss") -IncludeDateTimePartInOutputFolderName:$false
        
        It "Function $FunctionName - $ContextName - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output"
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
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $Result = New-OutputFolder -NamePartsSeparator "_"
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output_20161108"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 0
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            $Result.ExitCodeDescription | Should Be "Everything is fine :-)"
        }
        
    }
    
    $ContextName = "run with all name parts, with DateTimePartInOutputFolderName"
    
    Context "Function $FunctionName - $ContextName" {
        
        $Result = New-OutputFolder -OutputFolderNamePrefix "AAA" -OutputFolderNameMidPart "BBB" -OutputFolderNameSuffix "CCC" -DateTimePartInOutputFolderName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss")
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "AAA-BBB-20161101-CCC"
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
        
        $Result = New-OutputFolder -OutputFolderNamePrefix "AAA" -OutputFolderNameMidPart "BBB" -OutputFolderNameSuffix "CCC" -DateTimePartInOutputFolderName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MMM-dd hh:mm:ss") -IncludeDateTimePartInOutputFolderName:$false
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "AAA-BBB-CCC"
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
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $ParentPath = "TestDrive:\TestFolder"
        
        $Result = New-OutputFolder -ParentPath $ParentPath
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108"
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
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        $Result = New-OutputFolder -ParentPath $TestDestinationFolder
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108"
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
        
        It "Function $FunctionName -  $ContextName - OutputFolderPath - an object type" {
            { $Result = New-OutputFolder -ParentPath $TestDestinationFolder -BreakIfError } | Should Throw
        }
        
    }
    
    $ContextName = "run without parameters, destination file exists, decision leave"
    
    Context "Function $FunctionName - $ContextName" {
        
        [System.String]$TestExistingFolder = "TestDrive:\Output-20161108"
        
        New-Item -Path $TestExistingFolder -ItemType Directory
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        Mock -ModuleName New-OutputObject -CommandName Get-OverwriteDecision -MockWith { Return [int]0 }
        
        $Result = New-OutputFolder
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 4
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            [System.String]$RequiredMessage = "The folder {0} already exist  - can't be overwritten" -f $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestExistingFolder")
            
            $Result.ExitCodeDescription | Should Be $RequiredMessage
        }
        
    }
    
    $ContextName = "run without parameters, destination file exists, decision overwrite"
    
    Context "Function $FunctionName - $ContextName" {
        
        [System.String]$TestExistingFolder = "TestDrive:\Output-20161108"
        
        New-Item -Path $TestExistingFolder -ItemType Directory
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        Mock -ModuleName New-OutputObject -CommandName Get-OverwriteDecision -MockWith { Return [int]1 }
        
        $Result = New-OutputFolder
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            
            $Result.OutputFolderPath | Should BeOfType System.Io.DirectoryInfo
        }
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - Name " {
            
            $Result.OutputFolderPath.Name | Should Be "Output-20161108"
        }
        
        
        It "Function $FunctionName - $ContextName - exit code" {
            
            $Result.ExitCode | Should Be 5
        }
        
        It "Function $FunctionName - $ContextName - exit code description" {
            
            [System.String]$RequiredMessage = "The folder {0} already exist  - can be overwritten" -f $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestExistingFolder")
            
            $Result.ExitCodeDescription | Should Be $RequiredMessage
        }
        
    }
    
    $ContextName = "run without parameters, destination directory exists, decision cancel"
    
    Context "Function $FunctionName - $ContextName" {
        
        [System.String]$TestExistingFolder = "TestDrive:\Output-20161108"
        
        New-Item -Path $TestExistingFolder -ItemType Directory
        
        Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }
        
        Mock -ModuleName New-OutputObject -CommandName Get-OverwriteDecision -MockWith { Return [int]2 }
        
        
        
        It "Function $FunctionName - $ContextName - OutputFolderPath - an object type" {
            { $Result = New-OutputFolder } | Should Throw
        }
        
        
    }
    
    
    Set-Location -Path $LocationAtBegin
}
