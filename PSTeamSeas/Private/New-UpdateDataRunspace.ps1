function New-UpdateDataRunspace {
    [CmdletBinding()]
    param()

    [powershell]::Create().AddScript{
        Try{
            $ErrorActionPreference = "Stop"
            Add-Type -AssemblyName PresentationFramework
            Add-Type -AssemblyName System.Windows.Forms

            #Import required assemblies and private functions
            Get-childItem -Path "$($DataHash.ModuleBase)\Private" -File -Recurse | ForEach-Object {Import-Module $_.FullName}
            Get-childItem -Path "$($DataHash.ModuleBase)\Public" -File -Recurse | ForEach-Object {Import-Module $_.FullName}
            Get-childItem -Path "$($DataHash.ModuleBase)\Classes" -File | ForEach-Object {Import-Module $_.FullName}

            Update-tsDonationData -ViewModel $DataHash.MainViewModel
        }
        catch{
            Show-Messagebox -Text $($_.Exception.Message) -Title "Data Runspace Error" -Icon Error
        }
    }
}