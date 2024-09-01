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

# Create activate_venv.bat 
$activateScriptContent = '@echo off
REM Activate the virtual environment in the current directory
if exist venv\Scripts\activate (
	call venv\Scripts\activate
)else (
	echo No virtual environment found in this directory.
)'

# Save the activate file 
$activateScriptContent | Out-File -FilePath "activate.bat" -Encoding ASCII


# Create the deactivate_venv.bat script
$deactivateScriptContent = '@echo off
REM Deactivate the virtual environment if it is active
REM This command directly calls the deactivate function in the same session.
call venv\Scripts\deactivate.bat || echo "No active virtual environment found."
'

# Save the deactivate file
$deactivateScriptContent | Out-File -FilePath "deactivate.bat" -Encoding ASCII

#print confirmation message
Write-Host "Project $projectName created and virtual environment established."
