function Update-tsDonationData {
    [CmdletBinding()]
    param(
        $ViewModel,
        [ValidateRange(5,100)]
        [int]$ListLength = 50
    )

    $TotalDonations = Get-tsTotalDonations
    $Recent = (Get-tsDonationInfo).Recent
    $TotalDonations.TotalDonations = $TotalDonations.TotalDonations - ($Recent | Measure-Object -Property pounds).Sum
    $ViewModel.TotalDonations.TotalDonations = $TotalDonations.TotalDonations

    foreach ($donation in $Recent){
        $ViewModel.TotalDonations.TotalDonations += $donation.pounds
        $ViewModel.RecentDonations.Insert(0,$donation)
        if ($ViewModel.RecentDonations.Count -gt $ListLength){
            $ViewModel.RecentDonations.RemoveAt($ViewModel.RecentDonations.Count - 1)
        }
        Start-Sleep -Seconds (Get-Random -Minimum 2 -Maximum 10)
    }
    Update-tsDonationData @PSBoundParameters
}