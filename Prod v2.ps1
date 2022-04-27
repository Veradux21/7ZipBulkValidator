<#How to call from cli#>
#pwsh E:\Assets\code.ps1

Set-PSDebug -Trace 0
<#Because Powershell can't persist aliases-----#>
Set-Variable -Name "7zExists" -Value (Get-Alias | Select-Object -Property Name | Select-String -Pattern "7z" | Measure-Object -Line)
if ( $7zExists.lines -gt 0)
    {
        Write-Output("7z exists")
    } else {
        Set-Alias -Name 7z -Value "C:\Program Files\7-Zip\7z.exe"
        Write-Output("Add 7z Alias")
    }
<#cd to right directory -----------------------#>
Set-Location -Path "E:\Assets\"
<#Set Width so it doesn't break Remove-Item----#>
$PSDefaultParameterValues=@{"Out-File:Width"="10000"}
<#Remove archive.log---------------------------#>
Remove-Item .\archive.log -ErrorAction SilentlyContinue
<#Clean error.log, Test archives, create log---#>
Remove-Item .\error.log -ErrorAction SilentlyContinue
Write-Output("Old Archive and Error removed. Start Test")
7z t -air!*.7z <# -xr@oldtested.txt #> 2>&1 1>>.\archive.log
Write-Output (Get-Content -Path ./archive.log | Measure-Object -Line)
<#Filter out Errors, archive already tested----#>
Select-String -Path ./archive.log -Pattern "ERROR.*:.*\.7z" -Raw > ./error.log
Select-String -Path ./archive.log -Pattern "Testing archive: " -Raw > ./tested.log
Write-Output (Get-Content ./error.log) 
<#Clean logs#>
(Get-Content ./error.log) -replace "ERROR: ", "" | Set-Content -Path ./error.log
(Get-Content ./tested.log) -replace "Testing archive: ", "" | Set-Content -Path ./tested.log
Write-Output (Get-Content ./error.log)
<#Append error.log to oldbad.log---------------#>
Get-Content -Path .\error.log | Add-Content -Path oldbad.log
Write-Output("Appended error to oldbad")
<#Filter out tested, format correctly, add to oldtested#>
# Select-String -Path ./archive.log -Pattern "Testing archive: " -Raw > ./justtested.log
(Get-Content ./tested.log) -replace "Testing archive: ", '' | Set-Content -Path ./justtested.log
(Get-Content ./justtested.log).ForEach({ '"{0}"' -f $_ }) | Add-Content -Path ./oldtested.txt
Write-Output("Added Quotes to oldtested")
<#Take breath, then delete each object in error.log#>
Start-Sleep -s 5
If ((Get-Content -Path ./error.log | Measure-Object -Line | Select-Object -expand Lines) -gt 0){
    Get-Content -Path ./error.log | ForEach-Object {Remove-Item -Force -Recurse -LiteralPath "$_"}
        Write-Output("Heresy Eliminated")
    }else{
       Write-Output("No errors") 
    }
    