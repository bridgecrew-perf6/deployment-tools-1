param(
	$NumberUsers = 0,
	$ErrorActionPreference = "Stop"
)

Try {
	If (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
		Throw "Insufficient permissions. Please re-open PowerShell as an administrator and run this script again."
	}

	$NumberUsers = Read-Host "Enter the number of users you would like to create:" 
	$Count = 1
	while ($Count -le $NumberUsers){
		$UserName = Read-Host "Enter a name for user $Count"
		$UserPass = Read-Host "Enter a secure password for user $Count" -AsSecureString
		New-LocalUser -Name $UserName -Password $UserPass
		Add-LocalGroupMember -Group "Administrators" -Member $UserName
		Write-Host "User $Count, $Username, configured successfully."
		$Count++
	}
	Write-Host "User configuration complete."
	Write-Host "New user configuration is as follows:"
	Get-LocalUser | Out-Host
	Read-Host "Press ENTER to exit"
	Exit 0
}
Catch {
	Write-Warning "An error occured. `n$_"
    Write-Host "Press ENTER to exit" -Back Black -Fore Yellow -NoNewLine
	Read-Host
	Exit 1 
}
