# Connect-ESXi
A powershell module to quickly view and access virtual machines on a VMware ESXi host.\
Requires VMware PowerCLI and does not work with the free edition of VMware ESXi due to API limitations.

## How to use
1. Download `Connect-ESXi.psm1` to a folder.
2. Run following to initialize module: `Import-Module .\Connect-ESXi.psm1`
3. Execute the function: Connect-ESXi

### Additional Information
This does not work with an ESXi free license due to API limitations.\
With this script you can see open snapshots and open VMRC (VMware Remote Console) which has to be installed first.\
Make sure you also have VMware PowerCLI installed.

If you want to have this function available at all times, create a folder named `Connect-ESXi` at this location:
`C:\Windows\System32\WindowsPowerShell\v1.0\Modules\`\
Then move the file `Connect-ESXi.psm1` into that folder.

If you have code-signing enabled you might want to sign the `psm1`-file, before using it.
