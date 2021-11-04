function Get-tsDonationInfo {
    [CmdletBinding()]
    param()

    Invoke-RestMethod -Uri "https://tscache.com/lb_recent.json"
}