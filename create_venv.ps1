# Define parameter that allows input as project name
param(
    [string]$projectName 
)

# Check if a name was provided
if (-not $projectName) {
    Write-Host "Please provide a project name." # Displays error message
    exit 1 #exits with error status
}

# Create a directory with project name
mkdir $projectName 
cd $projectName

# Initialize a git repository
git init 

# Create a virtual environment in the project directory
python -m venv venv 

#Activate the environment
.\venv\Scripts\Activate.ps1

#creates empty requirements.txt file
New-Item requirements.txt -ItemType File 

#Install dependencies
pip install pytest

# Save the list of packages to the requirements.txt file
pip freeze > requirements.txt

# create environment mananger script 
$environmentManagerScript = '@echo off
REM This script manages the virtual environment activation and deactivation.

if "%1" == "activate" (
    call venv\Scripts\activate
	echo Virtual envitonment activated.
) else if "%1" == "deactivate" (
    if defined VIRTUAL_ENV (
        call venv\Scripts\deactivate
        echo Virtual environment deactivated.
    ) else (
        echo No active virtual environment found.
    )
) else (
    echo Usage: manage_env.bat [activate^|deactivate]
)'

#save enironment file
$environmentManagerScript | Out-File -FilePath "manage_venv.bat" -Encoding ASCII

#print confirmation message
Write-Host "Project $projectName created and virtual environment established."
