. (Join-Path $PSScriptRoot ApacheLogsFunction.ps1)
. (Join-Path $PSScriptRoot Event-Log.ps1)
. (Join-Path $PSScriptRoot LABS_Process_Management_1.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Last 10 Apache Logs`n"
$Prompt += "2 - List Last 10 Failed Logins`n"
$Prompt += "3 - List At-Risk Users`n"
$Prompt += "4 - Start a Chrome Tab`n"
$Prompt += "5 - Exit`n"


$operation = $true

while($operation){
    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $apcheLogs = ApacheLogs1
        $tableRecords | Select-Object -Last 10 | Format-Table -AutoSize -Wrap 

    }
    elseif($choice -eq 2){
        $failedLogins = getFailedLogins 365
        Write-Host ($failedLogins | Format-Table | Out-String)
    }
    elseif($choice -eq 3){
        $atRiskUsers = getAtRiskUsers 365
        $atRiskUsers | ForEach-Object { Write-Host "User $($_.Name) is at risk with $($_.Count) login failures" }
    }
    elseif($choice -eq 4){
        openChrome
    }
    else{
        Write-Host "Selection failed. Please input a number 1-5"
        continue
    }
} #End of while-Loop