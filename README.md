# Horizon Custom Data Backup Tool
This tool is designed for easier data migration between Horizon installations. It helps you to easily backup or restore your custom configuration. I designed this tool primarily for data migration between the ground station computers.

## Donwload
Download the latest release [here](https://github.com/Griff-Aviation/HorizonCustomDataBackupTool/releases/latest).

## How to use it
I recommend to run the [moveConfig.ps1](/moveConfig.ps1) directly in Windows PowerShell. If you do not have access to the real keyboard, you can run the `gui.exe` and set everything by mouse only.

### PowerShell script moveConfig.ps1
When you execute the file in PowerShell with no arguments. This help text is displayed:

```
PS C:\Test\HorizonCustomDataBackupTool> .\moveConfig.ps1
This script has to run with administrator privilegies.
Designed for 'backup' and 'restore' custom configuration from MicroPilot's Horizon GCS.
Usage examples:
  moveConfig.ps1 backup .\myFolder
    - This creates a local directory 'myFolder' and copies all configuration files from Horizon to this 'myFolder' folder.

  moveConfig.ps1 restore .\myFolder
    - This restores all files from local 'myFolder' folder to Horizon.

  moveConfig.ps1 push .\myFolder -clean
    - This removes all the previous configuration from Horizon, and then restores all files from local 'myFolder' folder to Horizon.
```

The `backup` command makes a copy of all custom configuration files from Horizon to the selected folder. The `restore` command overrides the Horizon configuration files with the data in the selected directory. If you use the `-clean` switch, all the other configuration files are deleted from Horizon.

![GUI](/docs/powershell.png)

### Graphical User Interface gui.exe
The interface executes the commands specified in the PowerShell script corresponding to the clicked button.

![GUI](/docs/gui.png)
