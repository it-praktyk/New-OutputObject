# New-OutputFolder

## SYNOPSIS
Function intended for preparing a PowerShell object for output/create folders for e.g.
reports or logs.

## SYNTAX

```
New-OutputFolder [[-ParentPath] <String>] [[-OutputFolderNamePrefix] <String>]
 [[-OutputFolderNameMidPart] <String>] [[-OutputFolderNameSuffix] <String>]
 [[-IncludeDateTimePartInOutputFolderName] <Boolean>] [[-DateTimePartInOutputFolderName] <DateTime>]
 [[-NamePartsSeparator] <String>] [-BreakIfError]
```

## DESCRIPTION
Function intended for preparing a PowerShell custom object what contains e.g.
folder name for output/create folders.
The name is prepared based on prefix, middle name part, suffix, date, etc.
with verification if provided path exist and is it writable.

Returned object contains properties
- ParentPath - to use it please check an examples - as a \[System.IO.DirectoyInfo\]
- ExitCode
- ExitCodeDescription

Exit codes and descriptions
0 = "Everything is fine :-)"
1 = "Provided path \<PATH\> doesn't exist
2 = Empty code
3 = "Provided patch \<PATH\> is not writable"
4 = "The folder \<PATH\>\\\\\<FOLDER_NAME\> already exist  - can't be overwritten"
5 = "The folder \<PATH\>\\\\\<FOLDER_NAME\> already exist  - can be overwritten"

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$PerServerReportFolderMessages = New-OutputFolder -ParentPath 'C:\USERS\Wojtek\' -OutputFolderNamePrefix 'Messages' `
```

-OutputFolderNameMidPart 'COMPUTERNAME' \`
                                                                -IncludeDateTimePartInOutputFolderName:$true \`
                                                                -BreakIfError

PS \\\> $PerServerReportFolderMessages | Format-List

ParentPath                                           ExitCode ExitCodeDescription
--------------                                           -------- -------------------
C:\users\wojtek\Messages-COMPUTERNAME-20151021-0012-.txt        0 Everything is fine :-)

### -------------------------- EXAMPLE 2 --------------------------
```
$PerServerReportFolderMessages = New-OutputFolder -ParentPath 'C:\USERS\Wojtek\' -OutputFolderNamePrefix 'Messages' `
```

-OutputFolderNameMidPart 'COMPUTERNAME' -IncludeDateTimePartInOutputFolderName:$true
                                                                 -OutputFolderNameSuffix suffix \`
                                                                -BreakIfError


PS \\\> $PerServerReportFolderMessages.ParentPath | select Name,Directory | Format-List

Name      : Messages-COMPUTERNAME-20151022-235607-suffix.rxc
Directory : C:\USERS\Wojtek

PS \\\> ($PerServerReportFolderMessages.ParentPath).gettype()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     FolderInfo                                 System.IO.DirectorySystemInfo

## PARAMETERS

### -ParentPath
By default output folders are stored in subfolder "outputs" in current path

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolderNamePrefix
Prefix used for creating output folders name

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: Output
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolderNameMidPart
Part of the name which will be used in midle of output folder name

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolderNameSuffix
Part of the name which will be used at the end of output folder name

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeDateTimePartInOutputFolderName
Set to TRUE if report folder name should contains part based on date and time - format yyyyMMdd is used

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -DateTimePartInOutputFolderName
Set to date and time which should be used in output folder name, by default current date and time is used

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NamePartsSeparator
A char used to separate parts in the name, by default "-" is used

```yaml
Type: String
Parameter Sets: (All)
Aliases: Separator

Required: False
Position: 7
Default value: -
Accept pipeline input: False
Accept wildcard characters: False
```

### -BreakIfError
Break function execution if parameters provided for output folder creation are not correct or destination folder path is not writables

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.Object[]

## NOTES
AUTHOR: Wojciech Sciesinski, wojciech\[at\]sciesinski\[dot\]net  
KEYWORDS: PowerShell, Folder, FileSystem  

CURRENT VERSION
- 0.2.3 - 2016-11-08

HISTORY OF VERSIONS  
https://github.com/it-praktyk/New-OutputObject/VERSIONS.md

REMARKS
- The warning generated by PSScriptAnalyzer "Function 'New-OutputFolder' has verb that could change system state.
Therefore, the function has to support 'ShouldProcess'." is acceptable.

LICENSE
Copyright (c) 2016 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
Full license text: https://opensource.org/licenses/MIT

## RELATED LINKS

[https://github.com/it-praktyk/New-OutputObject](https://github.com/it-praktyk/New-OutputObject)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

