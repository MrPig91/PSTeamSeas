function Show-tsTeamSeas {
    [CmdletBinding()]
    param()
    Add-Type -AssemblyName PresentationFramework

    $DataHash = [hashtable]::Synchronized(@{})
    $InitialSessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    $DataSync = [System.Management.Automation.Runspaces.SessionStateVariableEntry]::new("DataHash", $DataHash, $Null)
    $InitialSessionState.Variables.Add($DataSync)

    $MaxThreads = 2
    $RunspacePool = [runspacefactory]::CreateRunspacePool(1,$MaxThreads,$InitialSessionState,$Host)
    $RunspacePool.ApartmentState = "STA"
    $RunspacePool.ThreadOptions = "ReuseThread"
    $RunspacePool.open()

    $RecentDonationsList =  [System.Collections.ObjectModel.ObservableCollection[Object]]::new()
    [System.Windows.Data.BindingOperations]::EnableCollectionSynchronization($RecentDonationsList, [System.Object]::new())

    $MainViewModel = [PSCustomObject]@{
        TotalDonations = Get-tsTotalDonations
        RecentDonations = $RecentDonationsList
    }
    $DataHash.MainViewModel = $MainViewModel
    $DataHash.ModuleBase = $MyInvocation.MyCommand.Module.ModuleBase

    $DataUpdateRunspace = New-UpdateDataRunspace
    $DataUpdateRunspace.RunspacePool = $RunspacePool
    [void]$DataUpdateRunspace.BeginInvoke()

    $PathToXAML = Join-Path $MyInvocation.MyCommand.Module.ModuleBase -ChildPath "WPF\MainWindow.xaml"
    $MainWindow = Import-XAML -PathToXAML $PathToXAML
    $MainWindow.DataContext = $DataHash.MainViewModel
    [void]$MainWindow.ShowDialog()
    $DataUpdateRunspace.Stop()
    $RunspacePool.Close()
    $RunspacePool.Dispose()
}