---
external help file: New-OutputObject-help.xml
online version: https://github.com/it-praktyk/New-OutputObject
schema: 2.0.0
---

# New-OutputFile

## SYNOPSIS
Function intended for preparing a PowerShell object for output files like reports or logs.

## SYNTAX

```
New-OutputFile [[-OutputFileDirectoryPath] <String>] [[-CreateOutputFileDirectory] <Boolean>]
 [[-OutputFileNamePrefix] <String>] [[-OutputFileNameMidPart] <String>] [[-OutputFileNameSuffix] <String>]
 [[-IncludeDateTimePartInOutputFileName] <Boolean>] [[-DateTimePartInOutputFileName] <DateTime>]
 [[-OutputFileNameExtension] <String>] [[-NamePartsSeparator] <String>] [[-BreakIfError] <Boolean>]
```

## DESCRIPTION
Function intended for preparing a PowerShell custom object what contains e.g.
file name for output files like reports or log.
The name is prepared based on prefix, middle name part,
suffix, date, etc.
with verification if provided path is available and writable.

Returned object contains properties
- OutputFilePath - to use it please check examples - as a \[System.IO.FileInfo\]
- ExitCode
- ExitCodeDescription

Exit codes and descriptions
0 = "Everything is fine :-)"
1 = "Provided path \<PATH\> doesn't exist and can't be created
2 = "Provided patch \<PATH\> doesn't exist and value for the parameter CreateOutputFileDirectory is set to False"
3 = "Provided patch \<PATH\> is not writable"
4 = "The file \<PATH\>\\\\\<FILE_NAME\> already exist  - can't be overwritten"
5 = "The file \<PATH\>\\\\\<FILE_NAME\> already exist  - can be overwritten"

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$PerServerReportFileMessages = New-OutputFile -OutputFileDirectoryPath 'C:\USERS\Wojtek\' -OutputFileNamePrefix 'Messages' `
```

-OutputFileNameMidPart 'COMPUTERNAME' \`
                                                                -IncludeDateTimePartInOutputFileName:$true \`
                                                                -BreakIfError:$true

PS \\\> $PerServerReportFileMessages | Format-List

OutputFilePath                                           ExitCode ExitCodeDescription
--------------                                           -------- -------------------
C:\users\wojtek\Messages-COMPUTERNAME-20151021-0012-.txt        0 Everything is fine :-)

### -------------------------- EXAMPLE 2 --------------------------
```
$PerServerReportFileMessages = New-OutputFile -OutputFileDirectoryPath 'C:\USERS\Wojtek\' -OutputFileNamePrefix 'Messages' `
```

-OutputFileNameMidPart 'COMPUTERNAME' -IncludeDateTimePartInOutputFileName:$true
                                                                -OutputFileNameExtension rxc -OutputFileNameSuffix suffix \`
                                                                -BreakIfError:$true


PS \\\> $PerServerReportFileMessages.OutputFilePath | select name,extension,Directory | Format-List

Name      : Messages-COMPUTERNAME-20151022-235607-suffix.rxc
Extension : .rxc
Directory : C:\USERS\Wojtek

PS \\\> ($PerServerReportFileMessages.OutputFilePath).gettype()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     FileInfo                                 System.IO.FileSystemInfo

## PARAMETERS

### -OutputFileDirectoryPath
By default output files are stored in subfolder "outputs" in current path

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

### -CreateOutputFileDirectory
Set tu TRUE if provided output file directory should be created if is missed

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

### -OutputFileNamePrefix
Prefix used for creating output files name

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

### -OutputFileNameMidPart
Part of the name which will be used in midle of output file name

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

### -OutputFileNameSuffix
{{Fill OutputFileNameSuffix Description}}

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

### -IncludeDateTimePartInOutputFileName
Set to TRUE if report file name should contains part based on date and time - format yyyyMMdd-HHmm is used

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

### -DateTimePartInOutputFileName
Set to date and time which should be used in output file name, by default current date and time is used

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

### -OutputFileNameExtension
Set to extension which need to be used for output file, by default ".txt" is used

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 8
Default value: .txt
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
Position: 9
Default value: -
Accept pipeline input: False
Accept wildcard characters: False
```

### -BreakIfError
Break function execution if parameters provided for output file creation are not correct or destination file path is not writables

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 10
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.Object[]

## NOTES
AUTHOR: Wojciech Sciesinski, wojciech\[at\]sciesinski\[dot\]net
KEYWORDS: PowerShell, FileSystem

CURRENT HISTORY
- 0.8.3 - 2016-11-07

REMARKS
- The warning generated by PSScriptAnalyzer "Function 'New-OutputFile' has verb that could change system state.
Therefore, the function has to support 'ShouldProcess'." is acceptable.

TODO
- replace long lines with parameters splattings in the examples
- Trim provided parameters
- Replace not standard chars ?
- Check if all chars are allowed in the file path e.g.
''%'  
- Add support to incrementint suffix -like "000124"


LICENSE
Copyright (c) 2016 Wojciech Sciesinski
This function is licensed under The MIT License (MIT)
Full license text: https://opensource.org/licenses/MIT

## RELATED LINKS

[https://github.com/it-praktyk/New-OutputObject](https://github.com/it-praktyk/New-OutputObject)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

