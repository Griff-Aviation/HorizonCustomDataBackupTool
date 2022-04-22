function printHelp
{
    Write-Host "This script has to run with administrator privilegies.";
    Write-Host "Designed for 'backup' and 'restore' custom configuration from MicroPilot's Horizon GCS.";
    Write-Host "Usage examples:";
    Write-Host "  moveConfig.ps1 backup .\myFolder";
    Write-Host "    - This creates a local directory 'myFolder' and copies all configuration files from Horizon to this 'myFolder' folder.";
    Write-Host "";
    Write-Host "  moveConfig.ps1 restore .\myFolder";
    Write-Host "    - This restores all files from local 'myFolder' folder to Horizon.";
    Write-Host "";
    Write-Host "  moveConfig.ps1 restore .\myFolder -clean";
    Write-Host "    - This removes all the previous configuration from Horizon, and then restores all files from local 'myFolder' folder to Horizon.";
}

$MPpath = "C:\Program Files (x86)\MicroPilot\Horizon3.7\";

function pull($destination)
{
    if(-Not (Test-Path -Path $destination)) {
        New-Item $destination -ItemType "directory";
    }
    $counter = 1;
    while (Test-Path $MPpath"\uav"$counter".ini" -PathType "Leaf") {
        Copy-Item $MPpath"\uav"$counter".ini" -Destination $destination"\uav"$counter".ini";
        $counter++;
    }
    Copy-Item $MPpath"\simulate.ini" -Destination $destination"\simulate.ini";
    Copy-Item -Path $MPpath"\fly" -Destination $destination"\fly" -Recurse;
    Copy-Item -Path $MPpath"\vrs" -Destination $destination"\vrs" -Recurse;
    Copy-Item -Path $MPpath"\geofence" -Destination $destination"\geofence" -Recurse;
    Write-Host "Pull complete.";
}

function push($source, $clean)
{
    if(-Not (Test-Path -Path $source)) {
        Write-Host "Source path ["$source"] does not exist. Execuction canceled.";
        return;
    }
    if($clean -eq "-clean") {
        $counter = 1;
        while (Test-Path $MPpath"\uav"$counter".ini" -PathType "Leaf") {
            Remove-Item $MPpath"\uav"$counter".ini" -Force;
            $counter++;
        }
        Remove-Item $MPpath"\simulate.ini" -Force;
        Remove-Item -Path $MPpath"\fly\*" -Force -Recurse;
        Remove-Item -Path $MPpath"\vrs\*" -Force -Recurse;
        Remove-Item -Path $MPpath"\geofence\*" -Force -Recurse;
        Write-Host "The current Horizon folder ["$MPpath"] cleaned.";
    }

    $counter = 1;
    while (Test-Path $source"\uav"$counter".ini" -PathType "Leaf") {
        Copy-Item $source"\uav"$counter".ini" -Destination $MPpath"\uav"$counter".ini" -Force;
        $counter++;
    }
    Copy-Item $source"\simulate.ini" -Destination $MPpath"\simulate.ini" -Force;
    Copy-Item -Path $source"\fly" -Destination $MPpath -Recurse -Force;
    Copy-Item -Path $source"\vrs" -Destination $MPpath -Recurse -Force;
    Copy-Item -Path $source"\geofence" -Destination $MPpath -Recurse -Force;
    Write-Host "Push complete.";
}

if ($args.Count -ge 2) {
    $cmd = $args[0];
    if ($cmd -eq "backup") {
        pull $args[1];
    } elseif ($cmd -eq "restore") {
        push $args[1] $args[2];
    } else {
        Write-Host "Unknown command:" $cmd;
    }
} else {
    printHelp;
}
