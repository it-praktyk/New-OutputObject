Function Test-CharsInPath {
    
<#	

    .SYNOPSIS

    .DESCRIPTION
    
    Exit codes
    
    - 0 - everything OK
    - 1 - nothing to check
    - 

    .PARAMETER Path
    
    .PARAMETER SkipCheckCharsInPath
    
    .PARAMETER SkipCheckCharsInFileName

    .EXAMPLE

    .LINK
    https://github.com/it-praktyk/New-OutputObject

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, FileSystem

    VERSIONS HISTORY

#>
    
    [cmdletbinding()]
    param (
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Path,
        [parameter(Mandatory = $false)]
        [switch]$SkipCheckCharsInPath,
        [parameter(Mandatory = $false)]
        [switch]$SkipCheckCharsInFileName
    
    )
    
    $PathInvalidChars = [System.IO.Path]::GetInvalidPathChars()
    
    $FileInvalidChars = [System.IO.Path]::GetInvalidFileNameChars()
    
    $PathType = ($Path.GetType()).Name
    
    If (@('DirectoryInfo', 'FileInfo') -contains $PathType) {
        
        If ($SkipCheckCharsInPath.IsPresent -and $PathType -eq 'DirectoryInfo') {
            
            Return 1
            
        }
        
        If ($SkipCheckCharsInFileName.IsPresent -and $PathType -eq 'FileInfo') {
            
            Return 1
            
        }
        
        
    }
    
    
    
}



