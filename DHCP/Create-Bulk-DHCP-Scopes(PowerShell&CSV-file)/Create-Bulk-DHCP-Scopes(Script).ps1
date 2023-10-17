# Put the files in a desired location and change the path in second line

$dhcpserver = "192.168.30.5"
$scopes = Import-Csv -Path "D:\Scripts\DHCP_Scopes_Info.csv" -Delimiter ","
foreach ($scope in $scopes)
{
	$name = $scope.name
	$description = $scope.description
Write-Output "Creating Scope  $name"
Add-DhcpServerv4Scope -ComputerName $dhcpserver -Name "$name" -Description "$description" -StartRange $scope.startrange -EndRange $scope.endrange -SubnetMask $scope.subnetmask -State Active -LeaseDuration 08.00:00:00
Set-DhcpServerv4OptionValue -Router $scope.router -ScopeId $scope.scopeid -ComputerName $dhcpserver
}