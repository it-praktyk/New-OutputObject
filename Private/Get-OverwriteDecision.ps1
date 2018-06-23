function Get-OverwriteDecision {
<#

    .SYNOPSIS
    Display dialog to user with question about overwrite file/folder.

    .DESCRIPTION
    PowerShell function intended to display dialog to user with a question about overwrite existing file/folder.

    Result/decission is returned as an exit code.

    Exit codes

    - 0 - keep existing
    - 1 - overwrite
    - 2 - cancel was selected

    The function doesn't test if the object

    .PARAMETER Path
    A path - as a string - to an item for what path decision need to be taken.

    .PARAMETER ItemType
    Type of object to overwrite. Used only to display.

    .EXAMPLE

    PS :\> Get-OverwriteDecision -Path C:\Windows\Temp\test.txt  -ItemType file

    Overwrite file
    The file C:\Windows\Temp\test.txt already exist
    [Y] Yes  [N] No  [C] Cancel  [?] Help (default is "Y"): y
    0

    Taking decission from user about overwrite file.

    Returned code means that user took decision to overwrite file.

    .OUTPUTS
    Exit code as an integer number. See description section to find the exit codes descriptions.

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, Dialog

    CURRENT VERSION
    - 0.1.2 - 2017-07-23

    HISTORY OF VERSIONS
    https://github.com/it-praktyk/New-OutputObject/CHANGELOG.md


#>

    param (
        [Parameter(Mandatory = $true)]
        [String]$Path,
        [Parameter(Mandatory = $false)]
        [ValidateSet('File', 'Folder')]
        [String]$ItemType = 'File'
    )

    #Dialog for decision to overwrite
    [String]$Title = "Overwrite {0}" -f $ItemType.ToLower()

    [String]$MessageText = "The {0} {1} already exist" -f $ItemType.ToLower(), $Path

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
                      "The folder already exists. Overwrite the existing folder."

    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
                     "Retain the existing folder."

    $cancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel", `
                         "Cancel."

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $cancel)

    $Answer = $host.ui.PromptForChoice($Title, $MessageText, $Options, 0)

    Return $Answer

}
