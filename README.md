# PSTeamSeas
A simple Powershell module for grabbing total donations and recent donations from the TeamSeas website. This module then uses this data to create a GUI application that will display the progress of TeamSeas in "real" time (it will be some time behind the website).

# Instructions
Open a powershell as administrator and run the following command:
```Powershell
Install-Module -Repository PSGallery -Name PSTeamSeas
```

If you want to update to the latest version, run this command:
```Powershell
Update-Module PSTeamSeas
```

If you get and error like the following "The 'Command' command was found in the module 'PSTeamSeas', but the module could not be loaded." then you will need to set your Execution Policy to remote signed by running the command below. Please note that execution policy is not a security feature, so changing it will not make your system more or less secure. Execution Policy is used to prevent you from accidentally running scripts that goes aganist the policy, but it does not prevent those scripts being ran in bypass mode. You can read more about Execution Policy on its about page [here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1)
```Powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
```

Once you have the the module installed you can run the command below to launch the GUI that give you "live" updates of the TeamSeas progress.
```Powershell
Show-tsTeamSeas
```
After running that command a GUI similar to one below should appear.

![Example TeamSeas GUI](https://github.com/MrPig91/PSTeamSeas/blob/main/TeamSeasGUI.png)

# How This App Was Built
Want to know how I built this app step by step? I made video of the process linked below!

[![TeamSeas App How To Video](https://img.youtube.com/vi/bDyQww7D4sI/0.jpg)](https://www.youtube.com/watch?v=bDyQww7D4sI)
