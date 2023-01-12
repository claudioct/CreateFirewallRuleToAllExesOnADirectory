$identifier = $args[0]
$path=$args[1]

$files = Get-ChildItem -Recurse "$path" -Include *.exe | Where-Object {! $_.PSIsContainer } | Select-Object Name, FullName

foreach ($file in $files) {
    $ruleName = $identifier + " " + $file.Name
    write-host Create Inbound and Outbound for file $file.Name with rule name$ruleName
    # write-host $file.FullName   
}

Write-Warning "Are you sure you want to create this firewall rules?" -WarningAction Inquire

foreach ($file in $files) {    
    $ruleName = $identifier + " " + $file.Name
    write-host $ruleName
    # write-host $file.FullName
    New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Program $file.FullName -Action Block
    New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Program $file.FullName -Action Block  
}