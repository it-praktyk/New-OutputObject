---
external help file: New-OutputObject-help.xml
online version: https://github.com/it-praktyk/New-OutputObject
schema: 2.0.0
---

# New-OutputFolder

## SYNOPSIS
Function intended for preparing a folder name for output folders like reports or logs.

## SYNTAX

```
New-OutputFolder [[-OutputFolderDirectoryPath] <String>] [[-CreateOutputFolderDirectory] <Boolean>]
 [[-OutputFolderNamePrefix] <String>] [[-OutputFolderNameMidPart] <String>]
 [[-OutputFolderNameSuffix] <String>] [[-IncludeDateTimePartInOutputFolderName] <Boolean>]
 [[-DateTimePartInOutputFolderName] <DateTime>] [[-NamePartsSeparator] <String>] [[-BreakIfError] <Boolean>]
```

## DESCRIPTION
Function intended for preparing folder name for output folders like reports or logs based on prefix, middle name part, suffix, date, etc.
with verification if provided path is writable

Returned object contains properties
- OutputFolderPath - to use it please check an examples - as a \[System.IO.FolderInfo\]
- ExitCode
- ExitCodeDescription

Exit codes and descriptions
0 = "Everything is fine :-)"
1 = "Provided path \<PATH\> doesn't exist and can't be created
2 = "Provided patch \<PATH\> doesn't exist and value for the parameter CreateOutputFolderDirectory is set to False"
3 = "Provided patch \<PATH\> is not writable"
4 = "The folder \<PATH\>\\\\\<FOLDER_NAME\> already exist  - can't be overwritten"
5 = "The folder \<PATH\>\\\\\<FOLDER_NAME\> already exist  - can be overwritten"

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$PerServerReportFolderMessages = New-OutputFolder -OutputFolderDirectoryPath 'C:\USERS\Wojtek\' -OutputFolderNamePrefix 'Messages' `
```

-OutputFolderNameMidPart 'COMPUTERNAME' \`
                                                                -IncludeDateTimePartInOutputFolderName:$true \`
                                                                -BreakIfError:$true

PS \\\> $PerServerReportFolderMessages | Format-List

OutputFolderPath                                           ExitCode ExitCodeDescription
--------------                                           -------- -------------------
C:\users\wojtek\Messages-COMPUTERNAME-20151021-0012-.txt        0 Everything is fine :-)

### -------------------------- EXAMPLE 2 --------------------------
```
$PerServerReportFolderMessages = New-OutputFolder -OutputFolderDirectoryPath 'C:\USERS\Wojtek\' -OutputFolderNamePrefix 'Messages' `
```

-OutputFolderNameMidPart 'COMPUTERNAME' -IncludeDateTimePartInOutputFolderName:$true
                                                                -OutputFolderNameExtension rxc -OutputFolderNameSuffix suffix \`
                                                                -BreakIfError:$true


PS \\\> $PerServerReportFolderMessages.OutputFolderPath | select Name,Directory | Format-List

Name      : Messages-COMPUTERNAME-20151022-235607-suffix.rxc
Directory : C:\USERS\Wojtek

PS \\\> ($PerServerReportFolderMessages.OutputFolderPath).gettype()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     FolderInfo                                 System.IO.FolderSystemInfo

## PARAMETERS

### -OutputFolderDirectoryPath
By default output folders are stored in subfolder "outputs" in current path

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: .\Outputs\
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreateOutputFolderDirectory
Set tu TRUE if provided output folder directory should be created if is missed

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: True
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
Position: 3
Default value: Output-
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolderNameSuffix
{{Fill OutputFolderNameSuffix Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
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
Position: 6
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
Position: 7
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
Position: 8
Default value: -
Accept pipeline input: False
Accept wildcard characters: False
```

### -BreakIfError
Break function execution if parameters provided for output folder creation are not correct or destination folder path is not writables

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 9
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.Object[]

## NOTES
AUTHOR: Wojciech Sciesinski, wojciech\[at\]sciesinski\[dot\]net
KEYWORDS: PowerShell, FolderSystem

VERSIONS HISTORY
- 0.1.0 - 2016-06-10 - Initial release, based on the New-OutputFolder v.
0.8.1
- 0.2.0 - 2016-06-10 - The parameter for a folder prefix removed, Pester test added

REMARKS
- The warning generated by PSScriptAnalyzer "Function 'New-OutputFolder' has verb that could change system state.
Therefore, the function has to support 'ShouldProcess'." is acceptable.

TODO
- replace long lines with parameters splattings in the examples
- Trim provided parameters
- Replace not standard chars ?
- Check if all chars are allowed in the folder name e.g.
''%'  
- Add support to incrementint suffix -like "000124"


LICENSE
Copyright (c) 2016 Wojciech Sciesinski
This function is licensed under The MIT License (MIT)
Full license text: https://opensource.org/licenses/MIT

## RELATED LINKS

[https://github.com/it-praktyk/New-OutputObject](https://github.com/it-praktyk/New-OutputObject)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

