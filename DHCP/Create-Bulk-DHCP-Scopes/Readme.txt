
According to the Microsoft Learn instructions (which you can find in the following link), we need to provide some information about the scopes.

https://learn.microsoft.com/en-us/powershell/module/dhcpserver/add-dhcpserverv4scope?view=windowsserver2022-ps


   [-ComputerName <String>]
   [-StartRange] <IPAddress>
   [-EndRange] <IPAddress>
   [-Name] <String>
   [-Description <String>]
   [-State <String>]
   [-SuperscopeName <String>]
   [-MaxBootpClients <UInt32>]
   [-ActivatePolicies <Boolean>]
   [-PassThru]
   [-NapEnable]
   [-NapProfile <String>]
   [-Delay <UInt16>]
   [-LeaseDuration <TimeSpan>]
   [-SubnetMask] <IPAddress>
   [-Type <String>]
   [-CimSession <CimSession[]>]
   [-ThrottleLimit <Int32>]
   [-AsJob]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]


The information includes the DHCP server address, scope name, start range, end range, description about the scope, lease duration in days, and more. You can access the complete list of parameters in the above link. 

Since we're going to create scopes with some default settings, we don't need to provide values for all of the parameters. Therefore, we just need to provide the required information which includes DHCP server address, start range, end range, scope name, scope description, scope ID, subnet mask, lease duration, and state.

You should create a CSV file and give a name to each column's header. I've already provided a sample CSV file to use in PowerShell script which you can download from the current directory.


######### Script explanation ################

# Define DHCP server address
$DHCPServerAddress = "172.50.60.70"
# Define a source CSV file to import scopes information and predefined values (I defined "," as column delimiter; if you open the csv file in notepad you must see "," after each valus)
# You must change the CSV file path based on your file location
$ScopesList = Import-Csv -Path "D:\Scripts\DHCP_Scopes_Info.csv" -Delimiter ","
# Looking up the CSV file by defining a loop. The script will search the file and get the scope name and description, then provide other parameters for it.
foreach ($Scope in $ScopesList)
{
	$ScopeName = $Scope.name
	$ScopeDescription = $Scope.description
# If you would like to see a massage while creating each scope, you can use Write-Output switch and enter your desired message
Write-Output "The script is creating scope  $ScopeName"
# Here, based on the information that are provided in CSV file, scopes will create. We don't need to specify State and LeaseDuration in CSV file and just privide a value in the below line of the script 
Add-DhcpServerv4Scope -ComputerName $DHCPServerAddress -Name "$ScopeName" -Description "$ScopeDescription" -StartRange $Scope.startrange -EndRange $Scope.endrange -SubnetMask $Scope.subnetmask -State Active -LeaseDuration 10.00:00:00
# Finally, the script gets the scope id or scope subnet address and sets default gateway or router address for that network.
Set-DhcpServerv4OptionValue -Router $Scope.router -ScopeId $Scope.scopeid -ComputerName $DHCPServerAddress
}



# Headers in our CSV file are: name,description,startrange,endrange,subnetmask,scopeid,router



