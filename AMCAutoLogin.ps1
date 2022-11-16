# Powershell script that opens that opens C:\SmartClientCache\Apps\Ellie Mae\Encompass - AMC\Encompass.exe and logs in to Encompass using the credentials provided in the command line arguments.

# Get the command line arguments
$arguments = $args

# Get the username and password from the command line arguments
$directory = $arguments[0]
$instanceid = $arguments[1]
$username = $arguments[2]
$password = $arguments[3]

# Kill any running Encompass tasks to prevent multiple instances from running
taskkill /im encompass.exe /f

# Get the path to the Encompass.exe file
$encompassPath = $directory + "\Encompass.exe"

# Start process to open encompass.exe from the directory provided in the command line arguments
$encompassProcess = Start-Process -FilePath $encompassPath -ArgumentList "-instanceid $instanceid" -PassThru

# Wait for the process to start
Start-Sleep -Seconds 2

# Check if the window "Encompass" opens here, if it does, then login
$encompassWindow = Get-Process -Name "Encompass" -ErrorAction SilentlyContinue

# If the window opens, then login
# if ($encompassWindow) {
#     $encompassLoginWindow = New-Object -ComObject WScript.Shell 
#     $encompassLoginWindow.AppActivate("Encompass")
#     Sleep 1
#     $encompassLoginWindow.SendKeys($instanceid)
#     $encompassLoginWindow.SendKeys("{ENTER}")
# }

# wait for the Encompass log In window to open
echo "Waiting for Encompass log in window to open"
Start-Sleep -Seconds 10

$encompassLoginWindow.SendKeys($password)
$encompassLoginWindow.SendKeys("{ENTER}")
