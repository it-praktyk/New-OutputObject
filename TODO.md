# TODO 

## New-OutputObject
- merge common code from New-Output* function to external/helper functions
- verify cross module versions of functions (used in the VERSION.md file, comment based helps, module manifest, etc.)
- integrate unit test via AppVeyour

## New-OutputFile
- Add verification of chars in path via Test-CharsInPath
- Add support to format for date part of the name
- Trim provided parameters
- Replace not standard chars ?
- Add support to incrementint suffix -like "000124"
- Add support for unknown errors - with exit code 2

## New-OutputFolder
- Add verification of chars in path via Test-CharsInPath
- Add support to format for date part of the name
- Trim provided parameters
- Replace not standard chars ?
- Add support to incrementint suffix -like "000124"
- Add support for unknown errors - with exit code 2

## Test-CharsInPath
- rewrite test using -testcases
- add support for an input from pipeline
- add support to return array of incorrect chars and them positions in string
- add support to verifying if non-english chars are used - displaying error/warning, returning other exit code
