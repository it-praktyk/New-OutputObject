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
    
    REMARKS:
    # Based on the Power Tips
    # Finding Invalid File and Path Characters
    # http://powershell.com/cs/blogs/tips/archive/2016/04/20/finding-invalid-file-and-path-characters.aspx

    VERSIONS HISTORY
    - 0.1.0 - 2016-06-06 - Initial release
    - 0.2.0 - 2016-06-06 - The second draft

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
    
    
    
    $PathInvalidChars = [System.IO.Path]::GetInvalidPathChars() #36 chars
    
    $FileInvalidChars = [System.IO.Path]::GetInvalidFileNameChars() #41 chars
    
    $FileOnlyInvalidChars =@(':','*','?','\','/') #5 chars - as a difference
    
    $PathType = ($Path.GetType()).Name
    
    If (@('DirectoryInfo', 'FileInfo') -contains $PathType) {
        
        If ($SkipCheckCharsInPath.IsPresent -and $PathType -eq 'DirectoryInfo') {
            
            Return 1
            
        }
        
        If ($SkipCheckCharsInFileName.IsPresent -and $PathType -eq 'FileInfo') {
            
            Return 1
            
        }
        
        
    }
    
    ElseIf ($PathType -eq 'String') {
        
    }
    
    Else {
        
        
        
    }
    
    
    
}



