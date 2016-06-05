# New-OutputFile
## SYNOPSIS
Function intended for preparing file object for output files like reports or logs

## SYNTAX
```powershell
New-OutputFile [[-OutputFileDirectoryPath] <String>] [[-CreateOutputFileDirectory] <Boolean>] [[-OutputFileNamePrefix] <String>] [[-OutputFileNameMidPart] <String>] [[-OutputFileNameSuffix] <String>] [[-IncludeDateTimePartInOutputFileName] <Boolean>] [[-DateTimePartInOutputFileName] <Nullable>] [[-OutputFileNameExtension] <String>] [[-ErrorIfOutputFileExist] <Boolean>] [[-BreakIfError] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Function intended for preparing filename for output files like reports or logs based on prefix, middle name part, suffix, date, etc. with verification if provided path is writable



### Returned object contains properties

- OutputFilePath - to use it please check an examples - as a [System.IO.FileInfo]
- ExitCode
- ExitCodeDescription



### Exit codes and descriptions

- 0 = "Everything is fine :-)"
- 1 = "Provided path &lt;PATH&gt; doesn't exist and can't be created
- 2 = "Provided patch &lt;PATH&gt; doesn't exist and value for the parameter CreateOutputFileDirectory is set to False"
- 3 = "Provided patch &lt;PATH&gt; is not writable"
- 4 = "The file &lt;PATH&gt;\\&lt;FILE_NAME&gt; already exist - can't be overwritten"
- 5 = "The file &lt;PATH&gt;\\&lt;FILE_NAME&gt; already exist - can be overwritten"

## PARAMETERS
### -OutputFileDirectoryPath &lt;String&gt;
By default output files are stored in subfolder "outputs" in current path
```
Required?                    false
Default value                .\Outputs\
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -CreateOutputFileDirectory &lt;Boolean&gt;
Set tu TRUE if provided output file directory should be created if is missed
```
Required?                    false
Default value                True
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OutputFileNamePrefix &lt;String&gt;
Prefix used for creating output files name
```
Required?                    false
Default value                Output-
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OutputFileNameMidPart &lt;String&gt;
Part of the name which will be used in midle of output file name
```
Required?                    false
Default value                false
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OutputFileNameSuffix &lt;String&gt;

```
Required?                    false
Default value                false
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -IncludeDateTimePartInOutputFileName &lt;Boolean&gt;
Set to TRUE if report file name should contains part based on date and time - format yyyyMMdd-HHmm is used
```
Required?                    false
Default value                True
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -DateTimePartInOutputFileName &lt;Nullable&gt;
Set to date and time which should be used in output file name, by default current date and time is used
```
Required?                    false
Default value                false
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OutputFileNameExtension &lt;String&gt;
Set to extension which need to be used for output file, by default ".txt" is used
```
Required?                    false
Default value                .txt
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -NamePartsSeparator &lt;String&gt;
Generate error if output file already exist
```
Required?                    false
Default value                True
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -BreakIfError &lt;Boolean&gt;
Break function execution if parameters provided for output file creation are not correct or destination file path is not writables
```
Required?                    false
Default value                True
Accept pipeline input?       false
Accept wildcard characters?  false
```

## OUTPUTS
System.Object[]


## NOTES
AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net

KEYWORDS: PowerShell, FileSystem



VERSIONS HISTORY

- 0.1.0 - 2015-09-01 - Initial release
- 0.1.1 - 2015-09-01 - Minor update
- 0.2.0 - 2015-09-08 - Corrected, function renamed to New-OutputFile from New-ReportFileNameFullPath
- 0.3.0 - 2015-09-13 - implementation for DateTimePartInFileName parameter corrected, help updated, some parameters renamed
- 0.4.0 - 2015-10-20 - additional OutputFileNameSuffix parameter added, help updated, TODO updated
- 0.4.1 - 2015-10-21 - help corrected
- 0.5.0 - 2015-10-22 - Returned OutputFilePath changed to type [System.IO.FileInfo], help updated
- 0.6.0 - 2016-01-04 - The function renamed from New-OutputFileNameFullPath to New-OutputFile, help and TODO updated
- 0.7.0 - 2016-06-04 - The license changed to MIT, a code reformatted  
- 0.8.0 - 2016-06-05 - The parameter ErrorIfOutputFileExist removed, dialog about replacing existing files added  

TODO

- Trim provided parameters
- Check if all chars are allowed in the file path e.g. ''%'  
- Replace not standard chars ?
- Add support to incremented suffix -like "000124"


LICENSE

Copyright (c) 2016 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
The full license text: https://opensource.org/licenses/MIT  


## EXAMPLES
### EXAMPLE 1
```powershell
PS \>$PerServerReportFileMessages = New-OutputFile -OutputFileDirectoryPath 'C:\USERS\Wojtek\' -OutputFileNamePrefix 'Messages' -OutputFileNameMidPart 'COMPUTERNAME' -IncludeDateTimePartInOutputFileName:$true -BreakIfError:$true

PS \> $PerServerReportFileMessages | Format-List

OutputFilePath                                           ExitCode ExitCodeDescription

--------------                                           -------- -------------------

C:\users\wojtek\Messages-COMPUTERNAME-20151021-0012-.txt        0 Everything is fine :-)
```

### EXAMPLE 2
```powershell
PS \>$PerServerReportFileMessages = New-OutputFile -OutputFileDirectoryPath 'C:\USERS\Wojtek\' -OutputFileNamePrefix 'Messages' -OutputFileNameMidPart 'COMPUTERNAME' -IncludeDateTimePartInOutputFileName:$true -OutputFileNameExtension rxc -OutputFileNameSuffix 'suffix' -BreakIfError:$true

PS \> $PerServerReportFileMessages.OutputFilePath | select name,extension,Directory | Format-List

Name      : Messages-COMPUTERNAME-20151022-235607-suffix.rxc
Extension : .rxc
Directory : C:\USERS\Wojtek

PS \> ($PerServerReportFileMessages.OutputFilePath).gettype()

IsPublic IsSerial Name                                     BaseType

-------- -------- ----                                     --------

True     True     FileInfo                                 System.IO.FileSystemInfo
```
