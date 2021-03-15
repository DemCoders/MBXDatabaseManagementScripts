$mbx  = get-content C:\temp\newMailServerUsers_Top624.txt
$userName = $mbx |% {$_.Replace("@a360labs.com","")}
$newUserName = $userName | % {$_ + "2"}

$newUserName | % {

$smtpAddress = $_ + "@a360labs.com"

try{
get-mailbox $smtpAddress
}
catch{
error ; throw $_
}



}