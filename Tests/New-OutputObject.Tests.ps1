<#

.SYNOPSIS
Pester tests to validate the New-OutputObject module

.LINK
https://github.com/it-praktyk/New-OutputObject

.NOTES
AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
KEYWORDS: PowerShell, Pester, psd1, New-OutputObject

VERSIONS HISTORY
0.1.0 - 2016-11-07 - The first version of tests

#>


$ModuleName = "New-OutputObject"

#Provided path asume that your module manifest (a file with the psd1 extension) exists in the parent directory for directory where test script is stored
$RelativePathToModuleManifest = "{0}\..\{1}.psd1" -f $PSScriptRoot, $ModuleName

Describe "General tests for the $ModuleName module"  {

    BeforeAll {
        
        # If BeforeAll fails, Skip everything
        $Global:PSDefaultParameterValues["It:Skip"]=$true
        
		#Remove module if it's currently loaded 
		Get-Module -Name $ModuleName -ErrorAction SilentlyContinue | Remove-Module
        
		it 'Format-Pester should load without error' -Skip:$false {
            {Import-Module -FullyQualifiedName $RelativePathToModuleManifest -Force -Scope Global } | should not throw
            Get-Module -Name $ModuleName | should not be null

            # Since BeforeAll has passed, set skip to false
            $Global:PSDefaultParameterValues["It:Skip"]=$false
        }
    }

}
	
#Section mostly based on the blog post http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
#Author: François-Xavier Cat fxcat[at]lazywinadmin[dot]com
#Corrected by Wojciech Sciesinski wojciech[at]sciesinski[dot]net

Describe "Module $ModuleName functions help" -Tags "Help" {
    
    $FunctionsList = (get-command -Module $ModuleName | Where-Object -FilterScript { $_.CommandType -eq 'Function'} ).Name
    
    ForEach ($Function in $FunctionsList)
    {
        # Retrieve the Help of the function
        $Help = Get-Help -Name $Function -Full
        
        #Parsing Notes can be added also
        #$Notes = ($Help.alertSet.alert.text -split '\n')
		
		$Links = ($Help.relatedlinks.navigationlink.uri -split '\n')
        
        # Parse the function using AST
        $AST = [System.Management.Automation.Language.Parser]::ParseInput((Get-Content function:$Function), [ref]$null, [ref]$null)
		
        Context "$Function - Help"{
            
            It "Synopsis"{ $help.Synopsis | Should not BeNullOrEmpty }
            It "Description"{ $help.Description | Should not BeNullOrEmpty }
            			
            # Get the parameters declared in the Comment Based Help
            $RiskMitigationParameters = 'Whatif', 'Confirm'
            [String[]]$HelpParameters = $help.parameters.parameter | Where-Object name -NotIn $RiskMitigationParameters
			
            # Get the parameters declared in the AST PARAM() Block
            [String[]]$ASTParameters = $AST.ParamBlock.Parameters.Name.variablepath.userpath
			            
            It "Parameter - Compare amount of parameters Help vs AST" {
                $HelpParameters.count -eq $ASTParameters.count | Should Be $true
            }
            
            # Parameter Description
            $help.parameters.parameter | ForEach-Object {
                It "Parameter $($_.Name) - Should contains description"{
                    $_.description | Should not BeNullOrEmpty
                }
            }
            
            # Examples
            it "Example - Count should be greater than 0"{
                $Help.examples.example.code.count | Should BeGreaterthan 0
            }
            
            # Examples - Remarks (small description that comes with the example)
            foreach ($Example in $Help.examples.example)
            {
                it "Example - Remarks on $($Example.Title)"{
                    $Example.remarks | Should not BeNullOrEmpty
                }
            }
        }
    }
}

#Section mostly based on the blog post https://blog.kilasuit.org/2016/03/29/invoking-psscriptanalyzer-in-pester-tests-for-each-rule/
#Author: Ryan Yates ryan[dot]yates[at]kilasuit[dot]org
#Corrected by Wojciech Sciesinski wojciech[at]sciesinski[dot]net

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

$Scripts = Get-ChildItem “$here\..\” -Filter ‘*.ps1’ -Recurse | Where-Object {$_.name -NotMatch ‘Tests.ps1’}

$Modules = Get-ChildItem “$here\..\” -Filter ‘*.psm1’ -Recurse

$Excluderules = @("PSShouldProcess","PSUseShouldProcessForStateChangingFunctions")

$Rules = Get-ScriptAnalyzerRule | Where-Object -FilterScript { $_.RuleName -notin $Excluderules }


if ($Modules.count -gt 0) {

    Describe ‘Testing all Modules in this Repo to be be correctly formatted’ -Tag "PSScriptAnalyzer" {

        foreach ($module in $modules) {

            Context “Testing Module  – $($module.BaseName) for Standard Processing” {

                foreach ($rule in $rules) {

                    It “passes the PSScriptAnalyzer Rule $rule“ {

                        (Invoke-ScriptAnalyzer -Path $module.FullName -IncludeRule $rule.RuleName ).Count | Should Be 0

                    }

                }

            }

        }

    }

}

if ($Scripts.count -gt 0) {
    
    Describe 'Testing all Scripts in this Repo to be be correctly formatted' -Tag "PSScriptAnalyzer" {

        foreach ($Script in $scripts) {

            Context “Testing Script  – $($script.BaseName) for Standard Processing” {

                foreach ($rule in $rules) {

                    It “passes the PSScriptAnalyzer Rule $rule“ {

                        (Invoke-ScriptAnalyzer -Path $script.FullName -IncludeRule $rule.RuleName ).Count | Should Be 0

                    }

                }

            }

        }

    }

} 

#Describe Verify versions {


#}