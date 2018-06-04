<#
    .SYNOPSIS
    Pester tests to validate the New-OutputObject.ps1 function

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, Pester, psd1, New-OutputObject, New-OutputObject

    CURRENT VERSION
    - 0.9.13 - 2017-05-01

    HISTORY OF VERSIONS
    https://github.com/it-praktyk/New-OutputObject/CHANGELOG.md

#>

$ModuleName = "New-OutputObject"

$VerboseInternal = $false

#Provided path asume that your module manifest (a file with the psd1 extension) exists in the parent directory for directory where the current test script is stored
$RelativePathToModuleManifest = "{0}{2}..{2}{1}.psd1" -f $PSScriptRoot, $ModuleName, [System.IO.Path]::DirectorySeparatorChar

#Remove module if it's currently loaded
Get-Module -Name $ModuleName -ErrorAction SilentlyContinue | Remove-Module

Import-Module -FullyQualifiedName $RelativePathToModuleManifest -Force -Scope Global

$FunctionName = "New-OutputObject"

$ObjectTypes = @('File', 'Folder')

foreach ($ObjectType in $ObjectTypes) {

    If ($ObjectType -eq 'File') {

        $ItemTypeLower = 'file'

        $ExpectedObjectType = 'System.Io.FileInfo'

        [System.String]$DateTimeFormatToMock = 'yyyyMMdd-HHmmss'

        If ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and $ISLinux) {

            [String]$IncorrectFileNameOnly = "Test-File-201606$([char]0)08-1315.txt"

            [String]$IncorrectDateTimeFormat = "yyyy/MM/dd-HH:mm:ss"

        }
        ElseIf ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and $IsMacOS) {

            [String]$IncorrectFileNameOnly = "Test-File-201606$([char]58)08-1315.txt"

            [String]$IncorrectDateTimeFormat = "yyyyMMdd-HH:mm:ss"

        }
        Else {

            [String]$IncorrectFileNameOnly = 'Test-File-201606*08-1315.txt'

            [String]$IncorrectDateTimeFormat = "yyyyMMdd-HH:mm:ss"

        }

    }
    Else {

        $ItemTypeLower = 'folder'

        $ExpectedObjectType = 'System.Io.DirectoryInfo'

        [System.String]$DateTimeObjectToMock = 'yyyyMMdd'

        If ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and $ISLinux) {

            [String]$IncorrectDirectoryOnly = "/usr/share/loc$([char]0)al/"

            [String]$IncorrectDateTimeFormat = "yyyy/MM/dd-HH:mm:ss"

        }
        ElseIf ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and $IsMacOS) {

            [String]$IncorrectDirectoryOnly = "/usr/share/loc$([char]58)al/"

            [String]$IncorrectDateTimeFormat = "yyyy-MM-dd-HH:mm:ss"

        }
        ElseIf ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and $IsWindows) {

            #The differences between 'normal' PowerShell (based on PSEdition: Desktop, PSVersion 5.1.15063.483) and
            #PowerShell Core (based on PSEdition: Core, PSVersion: 6.0.0-beta) are
            #chars UTF8 34, 60,62 for [System.IO.Path]::GetInvalidPathChars()

            [String]$IncorrectDirectoryOnly = 'C:\AppData\Loc|al\'

            [String]$IncorrectDateTimeFormat = "yyyy-MM-dd-HH|mm:ss"

        }
        Else {

            [String]$IncorrectDirectoryOnly = 'C:\AppData\Loc>al\'

            [String]$IncorrectDateTimeFormat = "yyyy-MM-dd-HH>mm:ss"

        }

    }

    Describe "Tests for $FunctionName and the ObjectType [$ObjectType]" {

        $LocationAtBegin = Get-Location

        Set-Location TestDrive:

        $ContextName = "run without parameters"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType
            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0
            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"
            }

        }

        $ContextName = "run with OutputObjectNamePrefix"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "AAA-20161108-000002.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -OutputFileNamePrefix "AAA"

            }
            Else {
                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "AAA-20161108"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -OutputFolderNamePrefix  "AAA"

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -OutputObjectNamePrefix "AAA"

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }


            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0
            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"
            }
        }

        $ContextName = "run with OutputObjectNameMidPart"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-BBB-20161108-000002.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -OutputFileNameMidPart "BBB"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-BBB-20161108"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -OutputFolderNameMidPart "BBB"

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -OutputObjectNameMidPart "BBB"

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType
            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName
            }


            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0
            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"
            }

        }

        $ContextName = "run with OutputObjectNameSuffix"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002-CCC.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -OutputFileNameSuffix "CCC"

            }
            Else {
                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-CCC"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -OutputFolderNameSuffix "CCC"

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -OutputObjectNameSuffix "CCC"

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType
            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName
            }


            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }


        $ContextName = "run with DateTimePartInOutputFileName"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161101-120001' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161101-120001.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -DateTimePartInOutputFileName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161101' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161101"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -DateTimePartInOutputFolderName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -DateTimePartInOutputObjectName (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")


            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }

        $ContextName = "run with DateTimePartInOutputObjectName, without DateTimePart"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                $ExpectedOutputObjectName = "Output.txt"

                $params = @{

                    DateTimePartInOutputFileName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                    IncludeDateTimePartInOutputFileName = $false

                }

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal @params

            }
            Else {

                $ExpectedOutputObjectName = "Output"

                $params = @{

                    DateTimePartInOutputFolderName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                    IncludeDateTimePartInOutputFolderName = $false

                }

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal @params

            }

            $params = @{

                ObjectType = $ObjectType

                DateTimePartInOutputObjectName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                IncludeDateTimePartInOutputObjectName = $false

            }

            $Result = New-OutputObject @params

            It "Function $FunctionName - $ContextName - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }

        $ContextName = "run with OutputFileNameExtension"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.csv"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -OutputFileNameExtension ".csv"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -OutputFileNameExtension "csv"

            It "Function $FunctionName - $ContextName - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }

        $ContextName = "run with NamePartsSeparator"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output_20161108-000002.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -NamePartsSeparator "_"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output_20161108"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -NamePartsSeparator "_"

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -NamePartsSeparator "_"

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }


            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }

        $ContextName = "run with all name parts, with DateTimePartInOutputObjectName"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161101-120001' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "AAA-BBB-20161101-120001-CCC.txt"

                $params = @{

                    OutputFileNamePrefix = "AAA"

                    OutputFileNameMidPart = "BBB"

                    OutputFileNameSuffix = "CCC"

                    DateTimePartInOutputFileName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                }

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal @params

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161101' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "AAA-BBB-20161101-CCC"

                $params = @{

                    OutputFolderNamePrefix = "AAA"

                    OutputFolderNameMidPart = "BBB"

                    OutputFolderNameSuffix = "CCC"

                    DateTimePartInOutputFolderName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                }

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal @params

            }

            $params = @{

                ObjectType = $ObjectType

                OutputObjectNamePrefix = "AAA"

                OutputObjectNameMidPart = "BBB"

                OutputObjectNameSuffix = "CCC"

                DateTimePartInOutputObjectName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

            }

            $Result = New-OutputObject @params

            It "Function $FunctionName -  $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName -  $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName -  $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName -  $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }

        $ContextName = "run with all name parts, without DateTimePart"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                $ExpectedOutputObjectName = "AAA-BBB-CCC.txt"

                $params = @{

                    OutputFileNamePrefix = "AAA"

                    OutputFileNameMidPart = "BBB"

                    OutputFileNameSuffix = "CCC"

                    DateTimePartInOutputFileName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                    IncludeDateTimePartInOutputFileName = $false

                }

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal @params

            }
            Else {

                $ExpectedOutputObjectName = "AAA-BBB-CCC"

                $params = @{

                    OutputFolderNamePrefix = "AAA"

                    OutputFolderNameMidPart = "BBB"

                    OutputFolderNameSuffix = "CCC"

                    DateTimePartInOutputFolderName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                    IncludeDateTimePartInOutputFolderName = $false

                }

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal @params

            }

            $params = @{

                ObjectType = $ObjectType

                OutputObjectNamePrefix = "AAA"

                OutputObjectNameMidPart = "BBB"

                OutputObjectNameSuffix = "CCC"

                DateTimePartInOutputObjectName = (Get-Date -Date "2016-11-01 12:00:01" -Format "yyyy-MM-dd hh:mm:ss")

                IncludeDateTimePartInOutputObjectName = $false

            }

            $Result = New-OutputObject @params

            It "Function $FunctionName -  $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName -  $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName -  $ContextName - exit code" {

                $Result.ExitCode | Should -Be 0

                $ResultProxyFunction.ExitCode | Should -Be 0

            }

            It "Function $FunctionName -  $ContextName - exit code description" {

                $Result.ExitCodeDescription | Should -Be "Everything is fine :-)"

                $ResultProxyFunction.ExitCodeDescription | Should -Be "Everything is fine :-)"

            }

        }

        $ContextName = "run without parameters, non existing destination directory."

        Context "Function $FunctionName - $ContextName" {

            $ParentPath = "TestDrive:\TestFolder"

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -ParentPath $ParentPath

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -ParentPath $ParentPath

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -ParentPath $ParentPath

            It "Function $FunctionName -  $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName -  $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName -  $ContextName - exit code" {

                $Result.ExitCode | Should -Be 1

                $ResultProxyFunction.ExitCode | Should -Be 1

            }

            It "Function $FunctionName -  $ContextName - exit code description" {

                [System.String]$RequiredMessage = "Provided parent path {0} doesn't exist" -f $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$ParentPath")

                $Result.ExitCodeDescription | Should -Be $RequiredMessage

            }

        }

        $ContextName = "run with existing, non writable destination folder."

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

            }

            [String]$TestDestinationFolder = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("TestDrive:\ExistingNotWritable\")

            New-Item -Path $TestDestinationFolder -ItemType Directory | Out-Null

            If ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and ($ISLinux - $IsMacOS))  {

                & chmod 0550 $TestDestinationFolder

            }
            #Windows
            Else {

                $ChangedACL = $OriginalAcl = Get-Acl -Path $TestDestinationFolder

                $colRights = [System.Security.AccessControl.FileSystemRights]"AppendData,WriteData"

                $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None

                $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::InheritOnly

                $objType = [System.Security.AccessControl.AccessControlType]::Deny

                $objUser = New-Object System.Security.Principal.NTAccount($(whoami))

                $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule ($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType)

                $ChangedACL.AddAccessRule($objACE)

                Set-ACL -Path $TestDestinationFolder $ChangedACL

            }

            If ($ObjectType -eq 'File') {

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -ParentPath $TestDestinationFolder

            }
            Else {

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -ParentPath $TestDestinationFolder

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -ParentPath $TestDestinationFolder

            It "Function $FunctionName -  $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName -  $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName -  $ContextName - exit code" {

                $Result.ExitCode | Should -Be 3

                $ResultProxyFunction.ExitCode | Should -Be 3

            }

            It "Function $FunctionName -  $ContextName - exit code description" {

                [System.String]$RequiredMessage = "Provided path {0} is not writable" -f $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestDestinationFolder")

                $Result.ExitCodeDescription | Should -Be $RequiredMessage

                $ResultProxyFunction.ExitCodeDescription | Should -Be $RequiredMessage

            }

            #Restore ACLs to cleanly remove TestDrive
            If ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and ($ISLinux - $IsMacOS))  {

                & chmod 0770 $TestDestinationFolder

            }

            Else {

                Set-ACL -Path $TestDestinationFolder $OriginalAcl

            }

        }

        $ContextName = "run with existing, non writable destination folder, break on error"

        Context "Function $FunctionName - $ContextName" {

            [String]$TestDestinationFolder = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("TestDrive:\ExistingNotWritable\")

            New-Item -Path $TestDestinationFolder -ItemType Container | Out-Null

            If ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and ($ISLinux - $IsMacOS))  {

                & chmod 0550 $TestDestinationFolder

            }

            Else {

                $ChangedACL = $OriginalAcl = Get-Acl -Path $TestDestinationFolder

                $colRights = [System.Security.AccessControl.FileSystemRights]"AppendData,WriteData"

                $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None

                $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::InheritOnly

                $objType = [System.Security.AccessControl.AccessControlType]::Deny

                $objUser = New-Object System.Security.Principal.NTAccount($(whoami))

                $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule ($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType)

                $ChangedACL.AddAccessRule($objACE)

                Set-ACL -Path $TestDestinationFolder $ChangedACL

            }

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                It "Function $FunctionName -  $ContextName - OutputObjectPath - an object type" {

                    { $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -ParentPath $TestDestinationFolder -BreakIfError } | Should -Throw

                    { $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -ParentPath $TestDestinationFolder -BreakIfError } | Should -Throw

                }

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                It "Function $FunctionName -  $ContextName - OutputObjectPath - an object type" {

                    { $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -ParentPath $TestDestinationFolder -BreakIfError } | Should -Throw

                    { $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -ParentPath $TestDestinationFolder -BreakIfError } | Should -Throw

                }

            }

            #Restore ACLs to cleanly remove TestDrive
            If ( ($PSVersionTable.ContainsKey('PSEdition')) -and ($PSVersionTable.PSEdition -eq 'Core') -and ($ISLinux - $IsMacOS))  {

                & chmod 0770 $TestDestinationFolder

            }

            Else {

                Set-ACL -Path $TestDestinationFolder $OriginalAcl

            }

        }

        [System.String]$ContextName = "run without parameters, destination {0} exists, decision overwrite" -f $ObjectType

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

                $OutputTypeToCreate = 'file'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108-000002.txt"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $OutputTypeToCreate = 'directory'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108"

            }

            New-Item -Path $TestExistingObject -ItemType $OutputTypeToCreate

            Mock -ModuleName New-OutputObject -CommandName Get-OverwriteDecision -MockWith { Return [int]0 }

            If ($ObjectType -eq 'File') {

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal

            }
            Else {

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 4

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                [System.String]$RequiredMessage = "The {0} {1} already exist - can be overwritten" -f $ObjectType, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestExistingObject")

                $Result.ExitCodeDescription | Should -Be $RequiredMessage

                $ResultProxyFunction.ExitCodeDescription | Should -Be $RequiredMessage

            }

        }

        [System.String]$ContextName = "run without parameters, destination {0} exists, decision leave" -f $ObjectType

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

                $OutputTypeToCreate = 'file'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108-000002.txt"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $OutputTypeToCreate = 'directory'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108"


            }


            New-Item -Path $TestExistingObject -ItemType $OutputTypeToCreate

            Mock -ModuleName New-OutputObject -CommandName Get-OverwriteDecision -MockWith { Return [int]1 }

            If ($ObjectType -eq 'File') {

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal

            }
            Else {

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal

            }

            $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 5

                $ResultProxyFunction.ExitCode | Should -Be 5

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                [System.String]$RequiredMessage = "The {0} {1} already exist - can't be overwritten" -f $ItemTypeLower, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestExistingObject")

                $Result.ExitCodeDescription | Should -Be $RequiredMessage

                $ResultProxyFunction.ExitCodeDescription | Should -Be $RequiredMessage

            }

        }

        $ContextName = "run without parameters, destination file exists, decision cancel"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

                $OutputTypeToCreate = 'file'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108-000002.txt"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $OutputTypeToCreate = 'directory'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108"

            }

            New-Item -Path $TestExistingObject -ItemType $OutputTypeToCreate

            Mock -ModuleName New-OutputObject -CommandName Get-OverwriteDecision -MockWith { Return [int]2 }

            If ($ObjectType -eq 'File') {

                It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                    { $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType } | Should -Throw

                    { $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal } | Should -Throw

                }

            }
            Else {

                It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                    { $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType } | Should -Throw

                    { $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal } | Should -Throw


                }
            }

        }

        [System.String]$ContextName = "run without parameters, destination {0} exists, the Force defined" -f $ObjectType

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

                $OutputTypeToCreate = 'file'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108-000002.txt"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

                $OutputTypeToCreate = 'directory'

                [System.String]$TestExistingObject = "TestDrive:\Output-20161108"


            }


            New-Item -Path $TestExistingObject -ItemType $OutputTypeToCreate

            If ($ObjectType -eq 'File') {

                $ResultProxyFunction = New-OutputFile -Force -Verbose:$VerboseInternal

            }
            Else {

                $ResultProxyFunction = New-OutputFolder -Force -Verbose:$VerboseInternal

            }

            $Result = New-OutputObject -Force -Verbose:$VerboseInternal -ObjectType $ObjectType

            It "Function $FunctionName - $ContextName - OutputObjectPath - an object type" {

                $Result.OutputObjectPath | Should -BeOfType $ExpectedObjectType

                $ResultProxyFunction.OutputObjectPath | Should -BeOfType $ExpectedObjectType

            }

            It "Function $FunctionName - $ContextName - OutputObjectPath - Name " {

                $Result.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

                $ResultProxyFunction.OutputObjectPath.Name | Should -Be $ExpectedOutputObjectName

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 6

                $ResultProxyFunction.ExitCode | Should -Be 6

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                [System.String]$RequiredMessage = "The {0} {1} already exist - can be overwritten due to used the Force switch" -f $ItemTypeLower, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$TestExistingObject")

                $Result.ExitCodeDescription | Should -Be $RequiredMessage

                $ResultProxyFunction.ExitCodeDescription | Should -Be $RequiredMessage

            }

        }

        $ContextName = "run with incorrect chars in DateTimePartFormat, BreakIfError"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108-000002' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108-000002.txt"

            }
            Else {

                Mock -ModuleName New-OutputObject -CommandName Get-Date -MockWith { Return [System.String]'20161108' } -ParameterFilter { $Format }

                $ExpectedOutputObjectName = "Output-20161108"

            }

            If ($ObjectType -eq 'File') {

                It "Function $FunctionName - $ContextName" {

                    { $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -DateTimePartFormat $IncorrectDateTimeFormat -BreakIfError } | Should -Throw

                    { $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -DateTimePartFormat $IncorrectDateTimeFormat -BreakIfError } | Should -Throw

                }

            }
            Else {

                It "Function $FunctionName - $ContextName" {

                    { $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -DateTimePartFormat $IncorrectDateTimeFormat -BreakIfError } | Should -Throw

                    { $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -DateTimePartFormat $IncorrectDateTimeFormat -BreakIfError } | Should -Throw

                }

            }

        }

        $ContextName = "run with incorrect chars in DateTimePartFormat, not BreakIfError"

        Context "Function $FunctionName - $ContextName" {

            If ($ObjectType -eq 'File') {

                $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -DateTimePartFormat $IncorrectDateTimeFormat

                $ResultProxyFunction = New-OutputFile -Verbose:$VerboseInternal -DateTimePartFormat $IncorrectDateTimeFormat

            }
            Else {

                $Result = New-OutputObject -Verbose:$VerboseInternal -ObjectType $ObjectType -DateTimePartFormat $IncorrectDateTimeFormat

                $ResultProxyFunction = New-OutputFolder -Verbose:$VerboseInternal -DateTimePartFormat $IncorrectDateTimeFormat

            }

            It "Function $FunctionName - $ContextName - exit code" {

                $Result.ExitCode | Should -Be 2

                $ResultProxyFunction.ExitCode | Should -Be 2

            }

            It "Function $FunctionName - $ContextName - exit code description" {

                [System.String]$RequiredMessage = "The name not created due to unaccepatable chars"

                $Result.ExitCodeDescription | Should -Be $RequiredMessage

                $ResultProxyFunction.ExitCodeDescription | Should -Be $RequiredMessage

            }


        }

        Set-Location -Path $LocationAtBegin

    }

}
