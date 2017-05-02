# TODO

Alligned to the version 0.9.7 - 2017-05-02

## New-OutputObject a module wide
- verify cross module versions of functions (used in the VERSION.md file, comment based helps, module manifest, etc.)
- integrate unit test via AppVeyour

## New-OutputObject a function wide
- Catch errors (?) when a relative path is not transformable to an absolute path
- Trim provided parameters
- Replace not standard chars (?)
- Add support for incremented suffix -like "000124"
- Add support for format output via ps1xml format file - check if https://github.com/StartAutomating/EZOut can be helpful

## New-OutputObject.Tests
- Try replace New-OutputObject in 'Mock -ModuleName New-OutputObject' with the variable: $ModuleName (?)

## Test-CharsInPath
- add support for an input from pipeline
- add support to return array of incorrect chars and them positions in string
- add support to verifying if non-english chars are used - displaying error/warning, returning other exit code
- add support for Turkish tests (?)  - http://mikefrobbins.com/2015/10/22/using-pester-to-test-powershell-code-with-other-cultures/

## Test-CharsInPath
- rewrite test using -testcases (?)

