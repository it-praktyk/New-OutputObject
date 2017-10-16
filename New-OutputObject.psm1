<#

    .SYNOPSIS
    The PowerShell module New-OutputObject function

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, FileSystem, File, Folder

    CURRENT VERSION
    - 0.3.0 - 2017-10-16

    HISTORY OF VERSIONS
    https://github.com/it-praktyk/New-OutputObject/CHANGELOG.md

#>

Set-StrictMode -Version Latest

#Get public and private function definition files

[String]$PublicFolderPath = "{0}{1}Public{1}*" -f $PSScriptRoot, [System.IO.Path]::DirectorySeparatorChar
[String]$PrivateFolderPath = "{0}{1}Private{1}*" -f $PSScriptRoot, [System.IO.Path]::DirectorySeparatorChar

$Public  = @( Get-ChildItem -Path $PublicFolderPath -Include *.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PrivateFolderPath -Include *.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        Write-Verbose "Import file: $($import.fullname)"
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import file $($import.fullname): $_"
    }
}
