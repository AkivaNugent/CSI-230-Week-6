. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Log.ps1)
. (Join-Path $PSScriptRoot String-Helper.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "10 - List At Risk Users"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        if(checkuser $name){
            Write-Host "This Username is taken"
            exit
            }
        else {
            Write-host "Username Accepted"
        }
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function
        if(checkPassword $password){Write-Host "Password Accepted"}
        else {
            Write-host "This password is not accepted"
            exit
        }

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        if(checkUser $name){Write-Host "okay"}
        else{
        Write-Host "this user does not exist"
        continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String


    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        if(checkUser $name){}
        else{
        Write-Host "this user does not exist"
        continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String

        
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
        if(checkUser $name){}
        else{
        Write-Host "this user does not exist"
        continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        if(checkUser $name){}
        else{
        Write-Host "this user does not exist"
        continue
        }


        $daysBack = Read-Host -Prompt "Please enter how far back to check"

        $userLogins = getLogInAndOffs $daysack
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        if(checkUser $name){}
        else{
        Write-Host "this user does not exist"
        continue
        }

        $daysBack = Read-Host -Prompt "Please enter how far back to check"

        $userLogins = getFailedLogins $daysBack

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    elseif($choice -eq 10){
        $daysBack = Read-Host -Prompt "Please enter how far back to check"
        $atRiskUsers = getAtRiskUsers $daysBack
        $atRiskUsers | ForEach-Object { Write-Host "User $($_.Name) is at risk with $($_.Count) login failures" }
    }

    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    else{
        Write-Host "Selection failed. Please input a number 1-10"
        continue
    }

}




