$VersionNumber = "1.0.$env:GITHUB_RUN_NUMBER"
$moduleName = 'PSTeamSeas'
$homedirectory = Join-Path -Path $env:GITHUB_WORKSPACE -ChildPath "PSTeamSeas"

$ModuleNamewithext = $moduleName + ".psm1"
$ManifesetName = $moduleName + ".psd1"
$modulePath = Join-Path -Path $env:GITHUB_WORKSPACE -ChildPath "$moduleName\$ModuleNamewithext"
New-Item -Path $homedirectory -ItemType File -Name $ModuleNamewithext
Write-Host "ModulePath $modulePath"
Write-Host "Module Path Exists: $(Test-Path -Path $modulePath)"

$publicFuncFolderPath = Join-Path -Path $env:GITHUB_WORKSPACE -ChildPath "$moduleName\Public"
$privateFuncFolderPath = Join-Path -Path $env:GITHUB_WORKSPACE -ChildPath "$moduleName\Private"
$classFolderPath = Join-Path -Path $env:GITHUB_WORKSPACE -ChildPath "$moduleName\Classes"
Write-Host "Public folder path $publicFuncFolderPath"
Write-Host "Path exists: $(Test-Path -Path $publicFuncFolderPath)"
$PublicFunctions = Get-ChildItem -Path $publicFuncFolderPath | Get-Content
$FunctionsToExport = (Get-ChildItem -Path $publicFuncFolderPath | select -ExpandProperty BaseName) -join ", "
$PrivateFunctions = Get-ChildItem -Path $privateFuncFolderPath -Recurse -File | Get-Content
$Classes = Get-ChildItem -Path $classFolderPath | Get-Content
Add-Content -Path $modulePath -Value $Classes
Add-Content -Path $modulePath -Value $PublicFunctions
Add-Content -Path $modulePath -Value $PrivateFunctions
Add-Content -Path $modulePath -Value "Export-ModuleMember -function $FunctionsToExport"

$FunctionsToExport =  $FunctionsToExport.split(", ",[System.StringSplitOptions]::RemoveEmptyEntries)

$manifestParameters = @{
     Path = "$homedirectory\$ManifesetName"
     RootModule = $ModuleName
     ModuleVersion = $VersionNumber
     FunctionsToExport = $FunctionsToExport
     Author = "Mrpig91"
     Description = "A powershell module keeping track of progress of TeamSeas."
}

New-ModuleManifest @manifestParameters

Write-Host "Manifest Path Exists: $(Test-Path -Path $homedirectory\$ManifesetName)"

Publish-Module -Path $homedirectory -NuGetApiKey $env:PWSHGALLERY -Tags "TeamSeas"