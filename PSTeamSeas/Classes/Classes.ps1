Add-Type @"
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Runtime.CompilerServices;

public class DonationOverview : INotifyPropertyChanged
{
    private int _totaldonations;
    private double _percentcomplete;
    private int _goal;

    public int TotalDonations
    {
        get { return _totaldonations; }
        set
        {
            _totaldonations = value;
            PercentComplete = Math.Round(((double)_totaldonations / Goal * 100), 2);
            OnPropertyChanged();
        }
    }

    public int Goal
    {
        get {return _goal; }
        set
        {
            _goal = value;
            OnPropertyChanged();
        }
    }

    public double PercentComplete
    {
        get {return _percentcomplete; }
        set
        {
            _percentcomplete = value;
            OnPropertyChanged();
        }
    }

    public event PropertyChangedEventHandler PropertyChanged;
    public void OnPropertyChanged([CallerMemberName] string caller = null)
    {
        var handler = PropertyChanged;
        if (handler != null)
        {
            handler(this, new PropertyChangedEventArgs(caller));
        }
    }

    public DonationOverview (int total, int goal)
    {
        Goal = goal;
        TotalDonations = total;
        PercentComplete = (Math.Round(((double)TotalDonations / Goal * 100), 2));
    }
}
"@