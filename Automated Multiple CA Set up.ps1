<#
.NOTES
Name:    Automated Multiple CA Set up.ps1
Created: 10/25/2017
Version: 1.0
Stored: 
Author:  John.bryant@cerner.com
Updated:


.DESCRIPTION
Discovers all Certificate Servers that have the Citris FAS logon Template and sets the FAS server Configuration to use those multiple CA servers

.ScriptFunctions

.Instructions
Run local on FAS Server or VIA Remote powershell
#>





#Get Certificate Authorities that have the Citirx_SmartcardLogon Certifcate
$CA = @(Get-FasMsCertificateAuthority)
#Build a Variable that contains the Addresses of those CA's
[array]$string1  = [System.Collections.ArrayList]@()
foreach($_ in $CA){
$aca = $_.address
$item = New-Object PSObject
$item | Add-Member -type NoteProperty -Name 'Address' -Value $aca
$string1 += $item
}

$caall = ($string1 |Select -ExpandProperty address) -join ","
$address = "$env:computername.$env:userdnsdomain"
Get-FasCertificateDefinition -Address $address
#set the FASCerverDefinition Certificate Authorities
Set-FasCertificateDefinition -Name default_Definition -Address $address -CertificateAuthorities @($caall) 
