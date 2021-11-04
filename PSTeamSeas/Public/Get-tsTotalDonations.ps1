function Get-tsTotalDonations {
    [CmdletBinding()]
    param(
        [int]$Goal = 30000000 
    )
    $totalDontions = Invoke-RestMethod -Uri "https://tscache.com/donation_total.json"
    [DonationOverview]::new($totalDontions.Count,$Goal)
}
