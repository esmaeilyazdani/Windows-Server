$DHCPServerAddress = "172.50.60.70"
$ScopesList = Import-Csv -Path "D:\Scripts\DHCP_Scopes_Info.csv" -Delimiter ","
foreach ($Scope in $ScopesList)
{
	$ScopeName = $Scope.name
	$ScopeDescription = $Scope.description
Write-Output "The script is creating scope  $ScopeName"
Add-DhcpServerv4Scope -ComputerName $DHCPServerAddress -Name "$ScopeName" -Description "$ScopeDescription" -StartRange $Scope.startrange -EndRange $Scope.endrange -SubnetMask $Scope.subnetmask -State Active -LeaseDuration 10.00:00:00
Set-DhcpServerv4OptionValue -Router $Scope.router -ScopeId $Scope.scopeid -ComputerName $DHCPServerAddress
}