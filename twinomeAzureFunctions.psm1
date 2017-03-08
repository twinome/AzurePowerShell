<# 
  _               _                                    
 / |_            (_)                                   
`| |-'_   _   __ __  _ .--.   .--.  _ .--..--.  .---.  
 | | [ \ [ \ [  |  |[ `.-. |/ .'`\ [ `.-. .-. |/ /__\\ 
 | |, \ \/\ \/ / | | | | | || \__. || | | | | || \__., 
 \__/  \__/\__/ [___|___||__]'.__.'[___||__||__]'.__.'                                         
 
/_____/_____/_____/_____/_____/_____/_____/_____/_____/

Script: twinomeAzureFunctions.ps1
Author: Matt Warburton
Date: 27/05/16
Comments: Azure functions
#>

Function Start-TWAzureVM {
    <#
    .SYNOPSIS
        Starts Azure VM
    .DESCRIPTION
        TEMPLATE
    .PARAMETER name
        VM name
    .EXAMPLE
        Start-TWAzureVM -name "A VM"
    #>
    [CmdletBinding()] 
    param (
        [string]$name,
        [string]$sName
    )
      
    BEGIN {
        $WarningPreference = 'Stop'
        $ErrorActionPreference = 'SilentlyContinue'    
    }
    
    PROCESS {
        
        try {
            $vm = Get-AzureVM -Name $name -ServiceName $sName
            $status = $vm.Status

                if($status -ne "ReadyRole") {

                    try {
                        Start-AzureVM -name $name -ServiceName $sName 
                        Write-Output "$name started"
                    }

                    catch {
                        $error = $_
                        Write-Output "$($error.Exception.Message) - Line Number: $($error.InvocationInfo.ScriptLineNumber)"  
                    }
                }
                else {
                    Write-Output "$name already started"    
                }
        }

        catch {
            $error = $_
            Write-Output "$($error.Exception.Message) - Line Number: $($error.InvocationInfo.ScriptLineNumber)" 
        }         
    }

    END { 
    }
} 

Function Stop-TWAzureVM {
    <#
    .SYNOPSIS
        Stops Azure VM
    .DESCRIPTION
        TEMPLATE
    .PARAMETER name
        VM name
    .EXAMPLE
        Stop-TWAzureVM -name "a VM"
    #>
    [CmdletBinding()] 
    param (
        [string]$name,
        [string]$sName
    )
      
    BEGIN {
        $WarningPreference = 'Stop'
        $ErrorActionPreference = 'SilentlyContinue'    
    }
    
    PROCESS {
        
        try {
            $vm = Get-AzureVM -Name $name -ServiceName $sName
            $status = $vm.Status

                if($status -eq "ReadyRole") {

                    try {
                        Stop-AzureVM -name $name -ServiceName $sName -Force
                        Write-Output "$name stopped"
                    }

                    catch {
                        $error = $_
                        Write-Output "$($error.Exception.Message) - Line Number: $($error.InvocationInfo.ScriptLineNumber)"  
                    }
                }
                else {
                    Write-Output "$name already stopped"    
                }
        }

        catch {
            $error = $_
            Write-Output "$($error.Exception.Message) - Line Number: $($error.InvocationInfo.ScriptLineNumber)" 
        }         
    }

    END { 
    }
} 