$DB1 = Get-Mailbox -Database a360labsdb1 -ResultSize unlimited
$DB2 = Get-Mailbox -Database a360labsdb2 -ResultSize unlimited
$DB3 = Get-Mailbox -Database a360labsdb3 -ResultSize unlimited
$DB4 = Get-Mailbox -Database a360labsdb4 -ResultSize unlimited

$i = 0
$c = 1
$u = 5

do {

$DB1[$i..$u] | % { New-MoveRequest -identity $_.Alias -AllowLargeItems -BadItemLimit 10000 }

$i+5
$u+5

sleep 3600

}
Until($u -gt $db1.count)