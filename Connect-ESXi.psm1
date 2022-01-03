function global:Connect-ESXi() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ESXiHost,
        [Parameter(Mandatory=$true)]
        [PSCredential]$Credential
    )
    try
    {
        Get-Datacenter >$null
        $esxiconnection = Get-VMHost
        $ESXiHost = $esxiconnection.Name
    }
    catch
    {
        $esxiconnection = Connect-VIServer -Server $ESXiHost -Credential $Credential
    }
    if ($esxiconnection) {
        Write-Host "Listing all VMs on" $ESXiHost
        $VMs = Get-VM
        $i = 0
        $vmOverview = @()
        ForEach ($VM in $VMs) {
            $i++
            $PowerState = "Unknown"
            if ($VM.PowerState -eq "PoweredOn") {
                $PowerState = "On"
            }
            if ($VM.PowerState -eq "PoweredOff") {
                $PowerState = "Off"
            }
            $snapshotcount = ($VM | Get-Snapshot | Measure-Object).Count
            $vmOverview += [pscustomobject] @{
                "Option"=$i
                "Name"=$VM.Name
                "Power"=$PowerState
                "Snapshots"=$snapshotcount
            }
        }
        $vmOverview += [pscustomobject] @{}
        $vmOverview += [pscustomobject] @{
            "Option"="d"
            "Name"="Disconnect ESXi"
        }
        $vmOverview | ft
        
        $vmnumber = Read-Host "Enter number of VM to open in VMRC or d to disconnect"
        if ($vmnumber -eq "d") {
            Disconnect-VIServer -Server * -Force
        } else {
            $vmnumber = [int]$vmnumber - 1
            $VMs[$vmnumber] | Open-VMConsoleWindow
            global:Connect-ESXi $ESXiHost $Credential
        }
    } else {
        Write-Host "Could not establish connection with: " $ESXiHost
    }
}
