$Delimiter = ","
$ConnectionSettings = "ConnectionSettings.csv"

$Settings = New-Object -TypeName psobject
$Settings | Add-Member -MemberType NoteProperty -Name UserName -Value ''
$Settings | Add-Member -MemberType NoteProperty -Name DestinationHostAddress -Value ''
$Settings | Add-Member -MemberType NoteProperty -Name DestinationHostPort -Value ''

if (![System.IO.File]::Exists($ConnectionSettings)) {

    $Settings.UserName               = Read-Host -Prompt 'Input the user name'
    $Settings.DestinationHostAddress = Read-Host -Prompt 'Input destination IP of your ssh connection'
    $Settings.DestinationHostPort    = Read-Host -Prompt 'Input destination port you are using for ssh'

    $Settings | Export-Csv -Path $ConnectionSettings -Delimiter $Delimiter 

} else {
    $Settings = Import-Csv -Path $ConnectionSettings -Delimiter $Delimiter 

} #end file input

ssh ($Settings.UserName + '@' + $Settings.DestinationHostAddress) -p $Settings.DestinationHostPort 