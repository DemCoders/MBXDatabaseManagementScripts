$dateRun= get-date -Format "ddMMMyyyy_HH_MM_ss"
$FileName = "onPremMbxstats_run" + $dateRun + ".csv"
$newlog= New-Item c:\temp\$FileName -Force
Add-Content -value "FolderName,ItemCount,ItemSize(MB) " -Path $newlog.fullname 

$emails = get-content C:\dev\newMailServerUsers_Top624.txt
$mbx = $emails | % { get-mailbox -identity $_ -ResultSize unlimited}

$mbx | % {

$output = Get-MailboxFolderStatistics -Identity $_.primarysmtpaddress.address | ? {$_.FolderPath -like "*inbox" -or $_.FolderPath -like "*calendar" -or $_.FolderPath -like "*contacts" -or $_.FolderPath -like "*personal" } | select Identity, ItemsInFolderAndSubfolders, FolderAndSubfolderSize
    $output | % { $FolderID = $_.Identity.tostring()
                  $ItemCount = $_.ItemsInFolderAndSubfolders.tostring()
                  $ItemSize = $_.FolderAndSubfolderSize.RoundUpToUnit("MB")
                  Add-Content -value "$FolderID,$ItemCount,$ItemSize " -Path $newlog.fullname 
                  }

}