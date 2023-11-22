## Run as admin.
## Either directly from powershell using ./users.ps1
## Or from cmd with ` powershell -file users.ps1 '
######
## First few lines are default accounts. Ignore them, & paste the authorized users below.
## One per line
 
$authUsers = @"
Administrator
DefaultAccount
Guest
WDAGUtilityAccount
 
"@
######
## First line is a default account. Ignore it, & paste the authorized administrators below.
## One per line
 
$authAdmins = @"
Administrator
 
"@
$machineUsers = Get-LocalUser | select -ExpandProperty Name
$machineAdmins = Get-LocalGroupMember -Group "Administrators" | select -ExpandProperty Name | ForEach-Object { ([string]$_).Split("\")[1] }
 
 
Write-Host -ForegroundColor Green "* These are bad users. Delete them."
 
$machineUsers.Split(" ") | ForEach {
    if ( -Not ($authUsers.Contains("$_")) ) { 
        Write-Host "$_"
    }
}
 
Write-Host -ForegroundColor Red "* These are incorrect admins. Change them."
 
$machineAdmins.Split(" ") | ForEach {
    if ( -Not ($authAdmins.Contains("$_")) ) { 
        Write-Host "$_"
    }
}