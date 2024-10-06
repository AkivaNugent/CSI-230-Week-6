#Q1
#$processesStartingWithC = Get-Process | Where-Object {$_.Name -ilike "C*" }
#$processesStartingWithC


#Q2
#$processesNotSys32 = Get-Process | Where-Object {$_.Path -notlike "*system32*"}
#$processesNotSys32

#Q3
#cd $PSScriptRoot
#$files=(Get-ChildItem)
#$folderpath="$PSScriptRoot/outfolder/"
#$filepath = Join-Path $folderpath "out.csv"
#$stoppedServices = Get-Service | Where-Object {$_.Status -eq 'Stopped'}
#$sortStoppedServices = $stoppedServices | Sort-Object Name
#$exportSortyedServices = $stoppedServices | Export-csv -Path $filepath

#$exportSortyedServices
#$sortStoppedServices

#Q4

function openChrome {
$chromeCheck = Get-Process -Name chrome -ErrorAction SilentlyContinue

if ($chromeCheck) {Write-Host "Chrome is already open."}
    else{
        Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "https://www.champlain.edu"
        }
} #End of openChrome