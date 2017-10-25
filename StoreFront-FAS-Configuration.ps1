
<#
.NOTES
Name:    StoreFront-FAS-Configuration.ps1
Created: 10/25/2017
Version: 1.0
Stored: 
Author:  John.bryant@cerner.com
Updated:


.DESCRIPTION
Configures StoreFront for use with Citrix Federated Authentication Service

.ScriptFunctions

.Instructions
Update $StoreVirtualPath to the name of your store
Run local on a StoreFront server or VIA remote PowerShell, then propagate changes to Store
#>








& "$Env:PROGRAMFILES\Citrix\Receiver StoreFront\Scripts\ImportModules.ps1"
$StoreVirtualPath = "/Citrix/Fas"
$store = Get-STFStoreService -VirtualPath $StoreVirtualPath
$auth = Get-STFAuthenticationService -StoreService $store
Set-STFClaimsFactoryNames -AuthenticationService $auth -ClaimsFactoryName "FASClaimsFactory"
Set-STFStoreLaunchOptions -StoreService $store -VdaLogonDataProvider "FASLogonDataProvider"
