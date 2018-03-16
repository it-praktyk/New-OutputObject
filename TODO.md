# TODO

Alligned to the version 0.9.10 - 2017-07-23

## New-OutputObject a module wide

- convert CHANGELOG.md to JAML or JSON format
- verify cross module versions of functions (used in the VERSION.md file, comment based helps, module manifest, etc.)
- add CI for the project

## New-OutputObject a function wide

- Exit codes and descriptions of them should to be moved to external parsable file
- Static descriptions should be replaced by description from the external file
- Check the function behaviour when called from other PSProvider than Filesystem
- Catch situation when provided relative parent path is too high, like "..\..\..\..\" - throw error(?)
  The current behaviouris: return root of psdrive
- Trim provided parameters and display warning (?)
- Replace non standard chars (?)
- Add support for incremented suffix -like "000124"
- Add support for format output via ps1xml format file - check if https://github.com/StartAutomating/EZOut can be helpful

## New-OutputObject.Tests

- Try replace New-OutputObject in 'Mock -ModuleName New-OutputObject' with the variable: $ModuleName (?)

## Test-CharsInPath

- add support for an input from pipeline
- add support to return array of incorrect chars and them positions in string
- add support to verifying if non-english chars are used - displaying error/warning, returning other exit code
- add support for Turkish tests (?)  - http://mikefrobbins.com/2015/10/22/using-pester-to-test-powershell-code-with-other-cultures/