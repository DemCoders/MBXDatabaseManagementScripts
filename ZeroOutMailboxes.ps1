#$badMBX = import-csv C:\temp\badmbx.csv
$badMBX = Get-ADUser -SearchBase "OU=a360labsRestoreUsers,DC=a360labs,DC=net" -Filter * -Properties userPrincipalName
$samAcct = $badMBX.samAccountName

## delete the current mailbox by removing all Exchange Attributes in Active Directory
$samAcct | % {

 set-aduser -Identity $_ -clear homeMDB, msExchMailboxGuid,msexchhomeservername,legacyexchangedn,mail,mailnickname,msexchmailboxsecuritydescriptor,msexchpoliciesincluded,msexchrecipientdisplaytype,msexchrecipienttypedetails,msexchumdtmfmap,msexchuseraccountcontrol,msexchversion

 }

## recreate the mailbox, you need Exchange Management Shell
$samAcct | % {
  
$smtpAddress = $_ + "@a360labs.com"
$displayName = $_.Replace("."," ")
$alias = $_

enable-mailbox -identity $smtpAddress -alias $alias -primarySMTPAddress $smtpAddress
set-mailbox -identity $smtpAddress -throttlingPolicy AutoBahn 

}





