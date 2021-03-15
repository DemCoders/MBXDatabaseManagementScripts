$mbx  = get-content C:\temp\newMailServerUsers_Top624.txt
$userName = $mbx |% {$_.Replace("@a360labs.com","")}
$newUserName = $userName | % {$_ + "2"}

$creds = Get-Credential
$pwd = $creds.Password

$newUserName | % {

$smtpAddress = $_ + "@a360labs.com"
$displayName = $_.Replace("."," ")
$alias = $_

new-mailbox -name $displayName -samaccountname $_  -userPrincipalName $smtpAddress -alias $alias -primarySMTPAddress $smtpAddress -throttlingPolicy AutoBahn -password $pwd -organizationalUnit a360labsRestoreUsers -ResetPasswordOnNextLogon:$false

}


