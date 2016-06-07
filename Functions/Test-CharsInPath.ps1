Function Test-CharsInPath {
    
<#	

    .SYNOPSIS

    .DESCRIPTION
    
    Exit codes
    
    - 0 - everything OK
    - 1 - nothing to check
    - 2 - an incorrect char found in the path part
    - 3 - an incorrect char found in the file name part
    - 4 - incorrect chars found in the path part and in the file name part

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
    - 0.2.0 - 2016-06-06 - The second draft, Pester tests updated
    - 0.3.0 - 2016-06-07 - The first working version :-)
    
    TODO
    - update help

#>
    
    [cmdletbinding()]
    [OutputType([System.Int32])]
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
    
    $FileNameInvalidChars = [System.IO.Path]::GetInvalidFileNameChars() #41 chars
    
    #$FileOnlyInvalidChars = @(':', '*', '?', '\', '/') #5 chars - as a difference
    
    $IncorectCharFundInFileName = $false
    
    $IncorectCharFundInPath = $false
    
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
        
        #Convert String to Array of chars
        $PathArray = $Path.ToCharArray()
        
        $PathLength = $PathArray.Length
        
        [array]::Reverse($PathArray)
        
        For ($i = 0; $i -lt $PathLength; $i++) {
            
            If (@('\', '/') -contains $PathArray[$i]) {
                
                [String]$DirectoryPath = [String]$Path.Substring(0, $($PathArray.Length - $i))
                                
                break
                
            }
            
        }
        
        If ([String]::IsNullOrEmpty($DirectoryPath)) {
            
            [String]$FileName = [String]$Path
            
        }
        Else {
            
            [String]$FileName = $Path.Replace($DirectoryPath, "")
            
        }
        
        
        [String]$MessageText = "The path provided as a string was devided to, directory part: {0} ; file name part: {1}" -f $DirectoryPath, $FileName
        
        Write-Verbose -Message $MessageText
        
        If ($SkipCheckCharsInPath.IsPresent -and $SkipCheckCharsInFileName.IsPresent) {
            
            Return 1
            
        }
        
        
        If (-not ($SkipCheckCharsInPath.IsPresent)) {
            
            foreach ($Char in $PathInvalidChars) {
                
                If ($DirectoryPath.ToCharArray() -contains $Char) {
                    
                    $IncorectCharFundInPath = $true
                    
                    [String]$MessageText = "The incorrect char {0} with the UTF code {1} found in the Path part" -f $Char, $([int][char]$Char)
                    
                    Write-Verbose -Message $MessageText
                                        
                }
                
            }
            
        }
        
        If (-not ($SkipCheckCharsInFileName.IsPresent)) {
            
            foreach ($Char in $FileNameInvalidChars) {
                                
                If ($FileName.ToCharArray() -contains $Char) {
                    
                    $IncorectCharFundInFileName = $true
                    
                    [String]$MessageText = "The incorrect char {0} with the UTF code {1} found in FileName part" -f $Char, $([int][char]$Char) 
                    
                    Write-Verbose -Message $MessageText
                    
                }
                
            }
            
        }
        
    }
    
    Else {
        
        [String]$MessageText = "Input object {0} can't be tested" -f ($Path.GetType()).Name
        
        Throw $MessageText
        
    }
    
    If ($IncorectCharFundInPath -and $IncorectCharFundInFileName) {
        
        Return 4
        
    }
    elseif ($IncorectCharFundInPath) {
        
        Return 2
        
    }
    
    elseif ($IncorectCharFundInFileName) {
        
        Return 3
        
    }
    Else {
        
        Return 0
        
    }
    
}